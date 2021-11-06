# Deployment script to configure App Gwy for a given Application

az_client_id=$1
az_client_secret=$2
az_tenant_id=$3
az_subs_id=$4

az login --service-principal -u $az_client_id -p $az_client_secret -t $az_tenant_id && az account set --subscription $az_subs_id

mod_dir_function="../../../../../../post-provision/key-lookup-function"

chmod +x "$mod_dir_function"/keylookup.sh
. "$mod_dir_function"/keylookup.sh


network_resource_grp=$( keylookup "nw_rg" )
gateway_name=$( keylookup "gateway_name" )
cluster_name=$( keylookup "aks_resource_name" )
cluster_rg=$( keylookup "aks_resource_group" )
keyvault=$( keylookup "env_keyvault" )
app_name="health-check"
dns_zone=$( keylookup "dns_zone" )
cluster_prefix=$( keylookup "cluster_web_prefix" )
api_prefix=$( keylookup "cluster_api_prefix" )
cluster_ingress_ip=$( keylookup "cluster_ingress_ip" )
k8s_cert_name="ingress-tls-ssl" # Possible Values : ssl-certs or api-ssl-certs

mod_dir="../../../../../../post-provision/appgwy-mgmt"

chmod +x "$mod_dir"/setup_v2.sh


echo " Prepare GWY for prefix : $cluster_prefix and $api_prefix"
./"$mod_dir"/setup_v2.sh $network_resource_grp $gateway_name $cluster_name $cluster_rg $keyvault $app_name $dns_zone $k8s_cert_name $cluster_prefix $api_prefix $cluster_ingress_ip