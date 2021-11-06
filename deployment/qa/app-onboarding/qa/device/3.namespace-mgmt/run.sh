# Master deployment file for App

az_client_id=$1
az_client_secret=$2
az_tenant_id=$3
az_subs_id=$4

az login --service-principal -u $az_client_id -p $az_client_secret -t $az_tenant_id && az account set --subscription $az_subs_id
mod_dir_function="../../../../../../post-provision/key-lookup-function"

chmod +x "$mod_dir_function"/keylookup.sh
. "$mod_dir_function"/keylookup.sh


cluster_name=$( keylookup "aks_resource_name" )
cluster_rg=$( keylookup "aks_resource_group" )
tenant_ad_group=$( keylookup "team_name" )

namespaces_file="./namespaces.properties"

mod_dir="../../../../../../post-provision/aks-ns-mgmt"

echo " Setting up Namespace for Cluster : $cluster_name "
chmod +x ./"$mod_dir"/setup_v2.sh

./"$mod_dir"/setup_v2.sh $cluster_name $cluster_rg $namespaces_file $tenant_ad_group

echo " Namespace Setup Done ... "
