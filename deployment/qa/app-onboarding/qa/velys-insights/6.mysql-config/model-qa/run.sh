#!/bin/bash

az_client_id=$1
az_client_secret=$2
az_tenant_id=$3
az_subs_id=$4

az login --service-principal -u $az_client_id -p $az_client_secret -t $az_tenant_id && az account set --subscription $az_subs_id
set -e
azure_dbname=$(grep azure_dbname ./model-qa/config.properties | cut -d"=" -f2)
app_dbname=$(grep app_dbname ./model-qa/config.properties | cut -d"=" -f2)
app_dbuser=$(grep app_dbuser ./model-qa/config.properties | cut -d"=" -f2)
appteam_name=$(grep appteam_name ./model-qa/config.properties | cut -d"=" -f2)
keyvault_name=$(grep keyvault_name ./model-qa/config.properties | cut -d"=" -f2)
dbadmin_user=$(grep dbadmin_user ./model-qa/config.properties | cut -d"=" -f2)
group_name=$(grep group_name ./model-qa/config.properties | cut -d"=" -f2)

#sql_path="$(pwd)"
mod_dir="../../../../../../post-provision/mysql-db-setup"
chmod +x "$mod_dir"/setup.sh
. "$mod_dir"/setup.sh
result=$(mysqlsetup "$azure_dbname" "$app_dbname" "$app_dbuser" "$appteam_name" "$keyvault_name" "$mod_dir" "$dbadmin_user" "$group_name")

if [ $result != 0 ]; then
    app_dbuser=${app_dbuser//[^[:alnum:]]/}
    echo "Saving $app_dbuser user secret to keyvault"
    az login --service-principal -u $az_client_id -p $az_client_secret -t $az_tenant_id && az account set --subscription $az_subs_id
    az keyvault secret set --name "${app_dbuser}" --vault-name "${keyvault_name}" --value "${result}" --output none
else
    echo "${app_dbname} already exists in  ${azure_dbname}" #dbname already exists
fi
