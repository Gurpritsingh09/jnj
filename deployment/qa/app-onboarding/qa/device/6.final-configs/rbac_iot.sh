# RBAC iot deployment file for App

#import keylookup function script to retrieve values from config.properties
mod_dir_function="../../../../../../post-provision/key-lookup-function"

chmod +x "$mod_dir_function"/keylookup.sh
. "$mod_dir_function"/keylookup.sh

iot_group_type=$(keylookup user_group_type)
iot_sp_type=$(keylookup user_sp_type)

team_name=$(keylookup team_name)
sp_name=$(keylookup sp_name)

uami_name=$(keylookup uami_name)

iot_group_role=$(keylookup role_reader)
iot_sp_role=$(keylookup role_contributor)

iot_resource_type=$(keylookup resource_type_iot)
iot_resource_name=$(keylookup iot_name)
iot_dps_resource_name=$(keylookup iot_dps_name)

mod_dir="../../../../../../post-provision/rbacs"

echo " Setting up iot RBACS for group: "$team_name", type "$iot_resource_type" and name "$iot_resource_name" "
sh "$mod_dir"/setup.sh "$iot_group_type" "$team_name" "$iot_group_role" "$iot_resource_type" "$iot_resource_name"

echo " Setting up iot RBACS for group: "$team_name", type "$iot_resource_type" and name "$iot_dps_resource_name" "
sh "$mod_dir"/setup.sh "$iot_group_type" "$team_name" "$iot_group_role" "$iot_resource_type" "$iot_dps_resource_name"

echo " Setting up iot RBACS for spn name: "$sp_name", type "$iot_resource_type" and name "$iot_resource_name" "
sh "$mod_dir"/setup.sh "$iot_sp_type" "$sp_name" "$iot_sp_role" "$iot_resource_type" "$iot_resource_name"

echo " Setting up iot RBACS for spn name: "$sp_name", type "$iot_resource_type" and name "$iot_dps_resource_name" "
sh "$mod_dir"/setup.sh "$iot_sp_type" "$sp_name" "$iot_sp_role" "$iot_resource_type" "$iot_dps_resource_name"

### add RBAC setup for user assigned managed identity
echo " Setting up iot RBACS for managed identity: "$uami_name", type "$iot_resource_type" and name "$iot_resource_name" "
sh "$mod_dir"/setup.sh "$iot_sp_type" "$uami_name" "$iot_sp_role" "$iot_resource_type" "$iot_resource_name"

echo " Setting up iot dps RBACS for managed identity: "$uami_name", type "$iot_resource_type" and name "$iot_dps_resource_name" "
sh "$mod_dir"/setup.sh "$iot_sp_type" "$uami_name" "$iot_sp_role" "$iot_resource_type" "$iot_dps_resource_name"

echo " iot RBAC Setup Done ... "