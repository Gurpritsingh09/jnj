az_client_id=$1
az_client_secret=$2
az_tenant_id=$3
az_subs_id=$4

az login --service-principal -u $az_client_id -p $az_client_secret -t $az_tenant_id && az account set --subscription $az_subs_id
mod_dir_function="../../../../../../post-provision/key-lookup-function"

chmod +x "$mod_dir_function"/keylookup.sh
. "$mod_dir_function"/keylookup.sh

# cluster_admin_grp="EUN-DS-QA-FHR-AKS-Admins"
# spn_name="eun-ds-jenkins-hsdi-qa"
cluster_admin_grp=$( keylookup "aks_admin_group_name" )
spn_name=$( keylookup "sp_name" )
tenant_ad_group=$( keylookup "team_name" )

echo "Setting up Tenant/ApplicationTeam groups "

mod_dir="../../../../../../post-provision/tenant-onboarding"

kwd="`pwd`"

# source ./"$mod_dir"/create_ad_group.sh
# source ./"$mod_dir"/initialize_tenant_group.sh $cluster_admin_grp $spn_name
source ./"$mod_dir"/create_ad_group_v2.sh $tenant_ad_group
source ./"$mod_dir"/initialize_tenant_group_v2.sh $cluster_admin_grp $spn_name $tenant_ad_group

echo " Setup Done ... "
