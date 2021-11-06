# RBAC EventHub deployment file for App

#import keylookup function script to retrieve values from config.properties
mod_dir_function="../../../../../../post-provision/key-lookup-function"

chmod +x "$mod_dir_function"/keylookup.sh
. "$mod_dir_function"/keylookup.sh

ev_resource_type=$( keylookup resource_type_eventhub )
ev_resource_name=$( keylookup eventhub_name )

uami_type=$( keylookup user_sp_type )
uami_name=$( keylookup uami_name )
uami_role=$( keylookup role_contributor )

sp_type=$( keylookup user_sp_type )
sp_name=$( keylookup sp_name )
sp_role=$( keylookup role_contributor )

group_type=$( keylookup user_group_type )
group_name=$( keylookup team_name )
group_role=$( keylookup role_reader )

mod_dir="../../../../../../post-provision/rbacs"

### add RBAC setup for team
echo " Setting up EventHub RBACS for group: "$group_name", type "$ev_resource_type" and name "$ev_resource_name" "
sh "$mod_dir"/setup.sh "$group_type" "$group_name" "$group_role" "$ev_resource_type" "$ev_resource_name"

### add RBAC setup for dsp-jenkins-device service principal
echo " Setting up EventHub RBACS for spn group: "$sp_name", type "$ev_resource_type" and name "$ev_resource_name" "
sh "$mod_dir"/setup.sh "$sp_type" "$sp_name" "$sp_role" "$ev_resource_type" "$ev_resource_name"

### add RBAC setup for user assigned managed identity
echo " Setting up EventHub RBACS for group: "$uami_name", type "$ev_resource_type" and name "$ev_resource_name" "
sh "$mod_dir"/setup.sh "$uami_type" "$uami_name" "$uami_role" "$ev_resource_type" "$ev_resource_name"

echo " EventHub RBAC Setup Done ... "