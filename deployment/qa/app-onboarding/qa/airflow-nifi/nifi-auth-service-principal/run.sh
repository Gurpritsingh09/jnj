#!/bin/bash

az_client_id=$1
az_client_secret=$2
az_tenant_id=$3
az_subs_id=$4

az login --service-principal -u $az_client_id -p $az_client_secret -t $az_tenant_id && az account set --subscription $az_subs_id

password=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 30 ; echo '')

display_name=$(grep display_name ./config.properties | cut -d "=" -f2)
reply_urls=$(grep reply_urls ./config.properties | cut -d "=" -f2 | sed "s/,/ /g")

### create App Registration
echo "Creating App Registration"
result=$(az ad app create \
  --display-name $display_name \
  --password $password \
  --reply-urls $reply_urls \
  --oauth2-allow-implicit-flow "true" \
  --required-resource-accesses @manifest.json)

app_id=$(az ad app list --display-name $display_name | grep appId | cut -d ":" -f2 | sed "s/\"//g" | sed "s/,//g")

### link App Registration with Service Principal
echo "Creating Service Principal"
result=$(az ad sp create --id $app_id)

### add additional App Registration owners
echo "Setting additional App Registration owners"
owner_ids=$(grep owner_ids ./config.properties | cut -d "=" -f2)
for owner in $(echo $owner_ids | sed "s/,/ /g"); do
  az ad app owner add --id $app_id --owner-object-id $owner
done

### upload client_secret to KeyVault
echo "Uploading App Registration $display_name client secret into $keyvault_name KeyVault"
keyvault_name=$(grep keyvault_name ./config.properties | cut -d"=" -f2)
az keyvault secret set --name "${display_name}" --vault-name "${keyvault_name}" --value "${password}" --output none

### print service principal details
echo "#### =============================================================== ####"
echo "####"
echo "#### Service Principal $display_name client id :: $app_id"
echo "#### Service Principal $display_name client secret :: $password"
echo "####"
echo "#### =============================================================== ####"

echo "Setting up the service principal completed."
