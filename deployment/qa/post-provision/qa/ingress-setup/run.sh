az_client_id=$1
az_client_secret=$2
az_tenant_id=$3
az_subs_id=$4

az login --service-principal -u $az_client_id -p $az_client_secret -t $az_tenant_id && az account set --subscription $az_subs_id


dns_zone_name="qa.surgicalnet.io"
dns_zone_rg="eun-ds-qa-nwk-sh"
keyvault="EUN-DS-QA-VLT"

#Assigning AKSPVCSNAP to Network Contributor Group
aks_sp_admin="AKSPVCSNAP"
network_contributor_group="EUN-DS-QA-PRM-Contributor"

echo "Assigning $aks_sp_admin to group: $network_contributor_group"
spn_id=`az ad sp list --display-name $aks_sp_admin | jq -r '.[].objectId'`
az ad group member add --group "$network_contributor_group" --member-id "$spn_id"


mod_dir="../../../../../post-provision/ngnix-setup"
clusters_rgs=`az aks list | jq -r -c '.[] | [.name,.resourceGroup]' | tr "[]" ' ' | tr -d '""' | tr -d " " `

#echo "---- Clusters Available ----- "
#"$clusters_rgs"
#clusters_rgs="DS-AKS-DFL-QA,EUN-DS-QA-AKS-DATA"
for cluster_rg in $clusters_rgs
do
    cluster_name=`echo $cluster_rg | cut -d',' -f1`
    rg_name=`echo $cluster_rg | cut -d',' -f2`
    
    echo " Processing Cluster : $cluster_name with Resource Group : $rg_name "
    
    echo "Retrieve Credential for cluster: $cluster_name"
    az aks get-credentials --resource-group $rg_name --name $cluster_name --overwrite-existing --admin
    chmod +x "$mod_dir"/setup.sh
    kubectl get ns ingress-basic || ./"$mod_dir"/setup.sh $cluster_name $rg_name $dns_zone_name $dns_zone_rg $keyvault
done

    echo "Retrieve Credential for cluster: $cluster_name"
    az aks get-credentials --resource-group $rg_name --name $cluster_name --overwrite-existing --admin 
    chmod +x "$mod_dir"/setup.sh
    kubectl get ns ingress-basic || ./"$mod_dir"/setup.sh $cluster_name $rg_name $dns_zone_name $dns_zone_rg $keyvault
done

