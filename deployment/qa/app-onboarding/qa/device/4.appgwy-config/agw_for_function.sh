#!/bin/bash
function get_cert () {
    ### parameters
    # $1 :: secret name in specified namespace
    # $2 :: namespace name where to look for certificates. Based on assumption that even external certs are imported into ingress-basic namespace on k8s cluster
    
    echo "Getting certificate contents"
    kubectl -n $2 get secret $1 -o yaml | grep tls.key | head -1 | cut -d : -f2 | tr -d ' ' | base64 -d > tls.key
    kubectl -n $2 get secret $1 -o yaml | grep tls.crt | head -1 | cut -d : -f2 | tr -d ' ' | base64 -d > tls.crt
}

function export_cert () {
    ### parameters
    # $1 :: name of the keyvault where password for .pfx certificates is stored
    # $2 :: generated .pfx certificate file name
    # $gateway_name :: globally available name of Application Gateway
    # $network_resource_group :: globally available name of Application Gateway Resource Group
    # $prefix :: name of the resource to create
    
    echo "Getting AppGW certificate password"
    cert_password=$(az keyvault secret show \
        --name "app-gwy-cert-admin" \
        --vault-name $1 \
        --query value \
    --output tsv)
    echo "Converting certificate into .pfx format"
    openssl pkcs12 -export -out $2.pfx -inkey tls.key -in tls.crt -passin pass:$cert_password -passout pass:$cert_password
    
    echo "Uploading certificate to Application Gateway"
    az network application-gateway ssl-cert create \
    --gateway-name $gateway_name \
    --resource-group $network_resource_group \
    --name $prefix \
    --cert-file $2.pfx \
    --cert-password $cert_password
}

function create_backend_address_pool () {
    ### parameters
    # $gateway_name :: globally available name of Application Gateway
    # $network_resource_group :: globally available name of Application Gateway Resource Group
    # $prefix :: name of the resource to create
    
    az network application-gateway address-pool create \
    --gateway-name $gateway_name \
    --resource-group $network_resource_group \
    --name $prefix \
    --servers "$backend_target.azurewebsites.net"
}

function create_custom_health_probe () {
    ### parameters
    # $gateway_name :: globally available name of Application Gateway
    # $network_resource_group :: globally available name of Application Gateway Resource Group
    # $prefix :: name of the resource to create
    
    az network application-gateway probe create \
    --gateway-name $gateway_name \
    --resource-group $network_resource_group \
    --name $prefix \
    --path "/" \
    --protocol "Https" \
    --host-name-from-http-settings true
}

function create_http_settings () {
    ### parameters
    # $gateway_name :: globally available name of Application Gateway
    # $network_resource_group :: globally available name of Application Gateway Resource Group
    # $prefix :: name of the resource to create
    
    az network application-gateway http-settings create \
    --gateway-name $gateway_name \
    --resource-group $network_resource_group \
    --name $prefix \
    --port 443 \
    --protocol Https \
    --cookie-based-affinity Disabled \
    --timeout 30 \
    --probe $prefix \
    --host-name-from-backend-pool true
}

function create_listener () {
    ### parameters
    # $gateway_name :: globally available name of Application Gateway
    # $network_resource_group :: globally available name of Application Gateway Resource Group
    # $prefix :: name of the resource to create
    # $frontend_port :: name of the agw frontend port to use
    # $frontend_ip :: name of the agw frontend ip configuration to use
    # $function_domain :: domain suffix created for azure function resources
    
    az network application-gateway http-listener create \
    --gateway-name $gateway_name \
    --resource-group $network_resource_group \
    --name $prefix \
    --frontend-port $frontend_port \
    --frontend-ip $frontend_ip \
    --host-name "$prefix.$function_domain" \
    --ssl-cert $prefix
}

function create_routing_rule () {
    ### parameters
    # $gateway_name :: globally available name of Application Gateway
    # $network_resource_group :: globally available name of Application Gateway Resource Group
    # $prefix :: name of the resource to create
    
    az network application-gateway rule create \
    --gateway-name $gateway_name \
    --resource-group $network_resource_group \
    --name $prefix \
    --rule-type Basic \
    --http-listener $prefix \
    --address-pool $prefix \
    --http-settings $prefix
}

function create_dns_entry () {
    ### parameters
    # $function_domain :: domain suffix created for azure function resources
    # $private_dns_zone_name :: name of private DNS zone to use
    # $prefix :: name of the resource to create
    
    az network private-dns record-set a add-record \
    --ipv4-address $appgw_private_ip \
    --record-set-name "$prefix.$function_domain" \
    --resource-group $private_dns_zone_rg \
    --zone-name $private_dns_zone_name
}

function create_public_dns_entry () {
    ### parameters
    # $function_domain :: domain suffix created for azure function resources
    # $private_dns_zone_name :: name of private DNS zone to use
    # $prefix :: name of the resource to create
    
    az network dns record-set a add-record \
    --ipv4-address $firewall_public_ip \
    --record-set-name $prefix.$public_dns_function_domain_suffix \
    --resource-group $public_dns_zone_rg \
    --zone-name $public_dns_zone_name
}

function set_ip_restrictions () {
    az functionapp config access-restriction add \
    --name $backend_target \
    --resource-group $function_rg \
    --rule-name "dsp-internal-allow" \
    --priority 201 \
    --action Allow \
    --ip-address $dsp_address_range
    
    az functionapp config access-restriction add \
    --name $backend_target \
    --resource-group $function_rg \
    --rule-name "appgw-allow" \
    --priority 202 \
    --action Allow \
    --ip-address $appgw_public_ip
}

# variables
prefix=$1
backend_target=$2

# constants
frontend_port="dp-feport"
frontend_ip="feip-private"
gateway_name="DS-QA-AGWY"
network_resource_group="EUN-DS-QA-NWK-SH"
function_domain="fun.qa.eun.surgicalnet.io"
vault="EUN-DS-QA-VLT"
cert_name="ingress-tls-ssl"
function_rg="EUN-DS-QA-AZF-DVC"

# private DNS parameters
private_dns_zone_name="qa.eun.surgicalnet.io"
private_dns_zone_rg="eun-ds-qa-nwk-sh"
appgw_private_ip="10.190.227.4"
private_dns_function_domain_suffix="fun"

# access restrictions parameters
dsp_address_range="10.190.0.0/16"
appgw_public_ip="40.127.144.138"

# SSL certificate
echo "Setup of SSL certificate for function : $prefix"
get_cert $cert_name "ingress-basic"
export_cert $vault $cert_name

# backend pool
echo "Creating backend pool for function : $prefix"
create_backend_address_pool

# custom health probe
echo "Creating custom health probe for function : $prefix"
create_custom_health_probe

# http settings
echo "Creating http settings for function : $prefix"
create_http_settings

# http listener
echo "Creating http listener for function : $prefix"
create_listener

# routing rule
echo "Creating routing rule for function : $prefix"
create_routing_rule

# private dns entry
echo "Creating A record in private DNS zone for function : $prefix"
create_dns_entry

# # public dns entry
# echo "Creating A record in public DNS zone for function : $prefix"
# create_public_dns_entry

# set proper access restrictions for function
echo "Creating access restriction rules for function : $prefix"
set_ip_restrictions
