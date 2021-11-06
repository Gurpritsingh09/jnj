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
keyvault=$( keylookup "env_keyvault" )
cluster_prefix=$( keylookup "cluster_web_prefix" )
cluster_ingress_ip=$( keylookup "cluster_ingress_ip" )

mod_dir="../../../../../../post-provision/ngnix-setup"

clusters_rgs="$cluster_name,$cluster_rg"

for cluster_rg in $clusters_rgs; do
    cluster_name=`echo $cluster_rg | cut -d',' -f1`
    rg_name=`echo $cluster_rg | cut -d',' -f2`
    
    echo " Processing Cluster : $cluster_name with Resource Group : $rg_name "
    
    echo "Retrieve Credential for cluster: $cluster_name"
    az aks get-credentials --resource-group $rg_name --name $cluster_name --overwrite-existing --admin
    
    chmod +x "$mod_dir"/setup_v2.sh
    kubectl get ns ingress-basic || ./"$mod_dir"/setup_v2.sh $cluster_name $rg_name $keyvault $cluster_prefix $cluster_ingress_ip
done
