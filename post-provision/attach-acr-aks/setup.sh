#!bin/bash

echo "Entered into Attach-ACR-AKS Setup"

aks_cluster="$1"
resource_group="$2"
acr_name="$3"

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]
then
    echo "There needs to be at least 3 parameters being inputed in the following format: 'aks_cluster' 'resource_group' 'acr_name' "
    exit 1 
else
    echo " Attaching ACR name: $acr_name to AKS Cluster: $aks_cluster in resource group: $resource_group "
    az aks update -n "$aks_cluster" -g "$resource_group" --attach-acr "$acr_name"
fi

echo " Done with Attach-ACR-AKS setup "