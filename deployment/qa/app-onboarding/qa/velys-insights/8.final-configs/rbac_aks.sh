# RBAC AKS deployment file for App 

#import keylookup function script to retrieve values from config.properties 
mod_dir_function="../../../../../../post-provision/key-lookup-function"

chmod +x "$mod_dir_function"/keylookup.sh
. "$mod_dir_function"/keylookup.sh

aks_group_type=$( keylookup user_group_type )

aks_group_name=$( keylookup team_name )
aks_admin_group_name=$( keylookup aks_admin_group_name )

aks_group_role=$( keylookup aks_role_cluster_user )
aks_admin_group_role=$( keylookup aks_role_cluster_admin )

aks_resource_type=$( keylookup resource_type_aks )
aks_resource_name=$( keylookup aks_resource_name )


mod_dir="../../../../../../post-provision/rbacs"


echo " Setting up AKS RBACS for group: "$aks_group_name", role "$aks_group_role", type "$aks_resource_type" and name "$aks_resource_name" "
#Give "AKS Kubernetes Cluster User Role" to group "DS-<ENV>-APPTEAM-<teamName>"
sh "$mod_dir"/setup.sh "$aks_group_type" "$aks_group_name" "$aks_group_role" "$aks_resource_type" "$aks_resource_name"

#Give "AKS Kubernetes Cluster Admin Role" to group "Cluster-Admin"
echo " Setting up AKS RBACS for admin: "$aks_admin_group_name", role "$aks_admin_group_role", type "$aks_resource_type" and name "$aks_resource_name" "
sh "$mod_dir"/setup.sh "$aks_group_type" "$aks_admin_group_name" "$aks_admin_group_role" "$aks_resource_type" "$aks_resource_name"  


echo " AKS RBAC Setup Done ... "
