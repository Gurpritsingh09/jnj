# attach ACR to AKS 

#import keylookup function script to retrieve values from config.properties 
mod_dir_function="../../../../../../post-provision/key-lookup-function"

chmod +x "$mod_dir_function"/keylookup.sh
. "$mod_dir_function"/keylookup.sh

aks_cluster=$( keylookup "aks_resource_name" ) #check if values exists for 'attach-acr-aks-aks_cluster' else put 'DS-NPD-AFLA' as default value
resource_group=$( keylookup "aks_resource_group" )
acr_name=$( keylookup "acr_resource_name" )


mod_dir="../../../../../../post-provision/attach-acr-aks"

echo " ACR name: $acr_name AKS Cluster: $aks_cluster resource group: $resource_group "
sh "$mod_dir"/setup.sh "$aks_cluster" "$resource_group" "$acr_name" 
