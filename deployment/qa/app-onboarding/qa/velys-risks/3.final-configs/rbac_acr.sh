# RBAC ACR deployment file for App 

#import keylookup function script to retrieve values from config.properties 
mod_dir_function="../../../../../../post-provision/key-lookup-function"

chmod +x "$mod_dir_function"/keylookup.sh
. "$mod_dir_function"/keylookup.sh

acr_group_type=$( keylookup user_group_type )
acr_group_name=$( keylookup team_name )
acr_group_role=$( keylookup role_reader )

acr_resource_type=$( keylookup resource_type_acr )
acr_resource_name=$( keylookup acr_resource_name )

acr_sp_type=$( keylookup user_sp_type )
acr_sp_name=$( keylookup sp_name )
acr_role_push=$( keylookup acr_role_push )
acr_role_pull=$( keylookup acr_role_pull )
role_contributor=$( keylookup role_contributor )

aks_cluster_sp=$( keylookup aks_cluster_sp )


mod_dir="../../../../../../post-provision/rbacs"


echo " Setting up ACR RBACS for group: "$acr_group_name", role: "$acr_group_role", type "$acr_resource_type" and name "$acr_resource_name" "
sh "$mod_dir"/setup.sh "$acr_group_type" "$acr_group_name" "$acr_group_role" "$acr_resource_type" "$acr_resource_name"

echo "Assigning role "$acr_role_push" to spn name: "$acr_sp_name", resource name: "$acr_resource_name""
sh "$mod_dir"/setup.sh "$acr_sp_type" "$acr_sp_name" "$acr_role_push" "$acr_resource_type" "$acr_resource_name"

echo "Assigning role "$acr_role_pull" to spn name: "$acr_sp_name", resource name: "$acr_resource_name""
sh "$mod_dir"/setup.sh "$acr_sp_type" "$acr_sp_name" "$acr_role_pull" "$acr_resource_type" "$acr_resource_name"

echo "Assigning role "$role_contributor" to spn name: "$acr_sp_name", resource name: "$acr_resource_name""
sh "$mod_dir"/setup.sh "$acr_sp_type" "$acr_sp_name" "$role_contributor" "$acr_resource_type" "$acr_resource_name"

echo "Assigning role "$acr_role_push" to aks cluster spn name: "$aks_cluster_sp", resource name: "$acr_resource_name""
sh "$mod_dir"/setup.sh "$acr_sp_type" "$aks_cluster_sp" "$acr_role_push" "$acr_resource_type" "$acr_resource_name"

echo "Assigning role "$acr_role_pull" to aks cluster spn name: "$aks_cluster_sp", resource name: "$acr_resource_name""
sh "$mod_dir"/setup.sh "$acr_sp_type" "$aks_cluster_sp" "$acr_role_pull" "$acr_resource_type" "$acr_resource_name"

echo " ACR RBAC Setup Done ... "
