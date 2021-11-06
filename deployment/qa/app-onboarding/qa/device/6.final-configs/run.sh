#!/bin/bash

# run master sh with 'sh run.sh $az_client_id $az_client_secret $az_tenant_id $az_subs_id'
az_client_id=$1
az_client_secret=$2
az_tenant_id=$3
az_subs_id=$4

az login --service-principal -u $az_client_id -p $az_client_secret -t $az_tenant_id && az account set --subscription $az_subs_id

sh rbac_aks.sh #always run
sh rbac_keyvault.sh
sh attach-acr-aks.sh
sh rbac_acr.sh
sh rbac_storageaccount.sh
#sh rbac_cosmos.sh
sh rbac_iot.sh
sh rbac_evhub.sh
sh rbac_functions.sh