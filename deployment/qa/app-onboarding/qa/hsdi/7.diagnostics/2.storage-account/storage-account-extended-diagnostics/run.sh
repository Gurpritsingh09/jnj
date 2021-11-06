#!bin/bash
# Storage-Account-Logging

az_client_id=$1
az_client_secret=$2
az_tenant_id=$3
az_subs_id=$4

az login --service-principal -u $az_client_id -p $az_client_secret -t $az_tenant_id && az account set --subscription $az_subs_id

#import keylookup function script to retrieve values from config.properties 
mod_dir_function="../../../../../../../../post-provision/key-lookup-function"
chmod +x "$mod_dir_function"/keylookup.sh
. "$mod_dir_function"/keylookup.sh

sa_names=$(keylookup storage_account_name)
#sa_rg=$(keylookup storage_account_rg)

mod_dir="../../../../../../../../post-provision/storage-account-logging"

for sa_name in $(echo $sa_names | sed "s/,/ /g"); do
    echo " Storage Account Name: $sa_name "
    sh "$mod_dir"/setup.sh "$sa_name" 
done
