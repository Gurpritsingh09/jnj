#!/bin/bash

network_resource_grp=$1
gateway_name=$2
cluster_name=$3
cluster_rg=$4
keyvault=$5
app_name=$6
dns_zone=$7
k8s_cert_name=$8 # Possible Values : ssl-certs or api-ssl-certs
cluster_prefix=$9
api_prefix=${10}
cluster_ingress_ip=${11}
# Prepare cluster-prefix


wildcard_cluster_prefix="$cluster_prefix"



# Check if Given Application already configured in App Gwy, if yes then don't configure it again

echo " Check if Gateway Rule: $cluster_prefix and $api_prefix exists already in App Gwy : $gateway_name"

app_rule_exists=`az network application-gateway rule show -g "$network_resource_grp" --gateway-name "$gateway_name" -n  $cluster_prefix | jq -r '.provisioningState'`

echo "Gateway Rule $cluster_prefix exists : $app_rule_exists"

if [ "$app_rule_exists" == "Succeeded" ]
then
    echo " .... Seems application cluster with prefix : $cluster_prefix is already configured in App Gwy : $gateway_name"
    echo " .... Skipping new config .... "
    exit 0
fi

az aks get-credentials -g $cluster_rg -n $cluster_name --admin --overwrite-existing

# Export PFX cert file

echo " Extract tls key & cert"

kubectl get secret $k8s_cert_name -n ingress-basic -o yaml | grep tls.key | head -1 | cut -d : -f2 | tr -d ' ' |base64 --decode >tls.key
kubectl get secret $k8s_cert_name -n ingress-basic -o yaml | grep tls.crt | head -1 | cut -d : -f2 | tr -d ' ' |base64 --decode >tls.crt

echo "Exporting secrets into PFX format"

cert_out_file_name="$wildcard_cluster_prefix.pfx"

cert_password=$(az keyvault secret show \
    --name "app-gwy-cert-admin" \
    --vault-name $keyvault \
    --query value \
--output tsv)

#echo "cert_out_file_name = $cert_out_file_name"
openssl pkcs12 -export -out $cert_out_file_name -inkey tls.key -in tls.crt -passin pass:$cert_password -passout pass:$cert_password

ls -l  $cert_out_file_name

# Create DNS "A" record for wildcard_cluster_prefix - PENDING : TO BE DONE Once Atul moves DNS Zone into right subscription


# Create a SSL Cert Record in Application Gateway
echo "Creating SSL Cert : $cluster_prefix in App Gwy : $gateway_name"

az network application-gateway ssl-cert create -g "$network_resource_grp" --gateway-name "$gateway_name" -n $cluster_prefix --cert-file ./$cert_out_file_name --cert-password $cert_password

# Create a backend pool

echo "Creating Backend Pool : $cluster_prefix in App Gwy : $gateway_name"

az network application-gateway address-pool create -g "$network_resource_grp" --gateway-name "$gateway_name" -n $cluster_prefix --servers $cluster_ingress_ip

# Create Probe
app_virtual_host=$app_name.$cluster_prefix.$dns_zone
app_virtual_hosts="*.$cluster_prefix.$dns_zone,*.$api_prefix.$dns_zone"
echo "Creating Probe : $cluster_prefix in App Gwy : $gateway_name  against host: $app_virtual_host"
az network application-gateway probe create -g "$network_resource_grp" --gateway-name "$gateway_name" -n $cluster_prefix --protocol https --host $app_virtual_host  --path "/" --timeout 30 --threshold 5

echo "Creating http settings : $cluster_prefix in App Gwy : $gateway_name"
az network application-gateway http-settings create -g "$network_resource_grp" --gateway-name "$gateway_name" -n $cluster_prefix --port 443 --protocol Https --cookie-based-affinity Disabled --timeout 30 --probe $cluster_prefix

echo "Creating http listener : $cluster_prefix in App Gwy : $gateway_name"
az network application-gateway http-listener create -g "$network_resource_grp" --gateway-name "$gateway_name" --frontend-port "dp-feport" -n $cluster_prefix --frontend-ip "feip-private" --host-names "$app_virtual_hosts" --ssl-cert $cluster_prefix || az network application-gateway http-listener create -g "$network_resource_grp" --gateway-name "$gateway_name" --frontend-port "dp-feport" -n $cluster_prefix --frontend-ip "Private" --host-names "$app_virtual_hosts" --ssl-cert $cluster_prefix

#feip-private
echo "Creating Gwy Rule : $cluster_prefix in App Gwy : $gateway_name"
az network application-gateway rule create -g "$network_resource_grp" --gateway-name "$gateway_name" -n $cluster_prefix --http-listener $cluster_prefix --rule-type Basic --address-pool $cluster_prefix --http-settings $cluster_prefix

echo " Finished App GWY configuration for $cluster_prefix and $api_prefix"