# RBAC KeyVault deployment file for App

#import keylookup function script to retrieve values from config.properties
mod_dir_function="../../../../../../post-provision/key-lookup-function"

chmod +x "$mod_dir_function"/keylookup.sh
. "$mod_dir_function"/keylookup.sh

kv_group_type=$( keylookup user_group_type )
kv_sp_type=$( keylookup user_sp_type )

team_name=$( keylookup team_name )
sp_name=$( keylookup sp_name )

kv_group_role=$( keylookup role_reader )
kv_sp_role=$( keylookup role_contributor )

kv_resource_type=$( keylookup resource_type_keyvault )
kv_resource_name=$( keylookup keyvault_name )

uami_name=$( keylookup uami_name )

mod_dir="../../../../../../post-provision/rbacs"


echo " Setting up Keyvault RBACS for group: "$team_name", type "$kv_resource_type" and name "$kv_resource_name" "
sh "$mod_dir"/setup.sh "$kv_group_type" "$team_name" "$kv_group_role" "$kv_resource_type" "$kv_resource_name"

echo " Setting up Keyvault RBACS for group: "$sp_name", type "$kv_resource_type" and name "$kv_resource_name" "
sh "$mod_dir"/setup.sh "$kv_sp_type" "$sp_name" "$kv_sp_role" "$kv_resource_type" "$kv_resource_name"

### add RBAC setup for user assigned managed identity
echo " Setting up Keyvault RBACS for group: "$uami_name", type "$kv_resource_type" and name "$kv_resource_name" "
sh "$mod_dir"/setup.sh "$kv_sp_type" "$uami_name" "$kv_sp_role" "$kv_resource_type" "$kv_resource_name"

echo " Keyvault RBAC Setup Done ... "
