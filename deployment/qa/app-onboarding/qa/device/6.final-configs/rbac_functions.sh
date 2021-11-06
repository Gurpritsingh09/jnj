# RBAC Azure Function deployment file for App

#import keylookup function script to retrieve values from config.properties
mod_dir_function="../../../../../../post-provision/key-lookup-function"

chmod +x "$mod_dir_function"/keylookup.sh
. "$mod_dir_function"/keylookup.sh

azf_resource_type=$( keylookup resource_type_function )

azf1_resource_name=$( keylookup function_name1 )
azf2_resource_name=$( keylookup function_name2 )
azf3_resource_name=$( keylookup function_name3 )
azf4_resource_name=$( keylookup function_name4 )

asp_resource_type=$( keylookup resource_type_app_service_plan )
asp_resource_name=$( keylookup appserviceplan_name )
appin_resource_type=$( keylookup resource_type_application_insights )
appin_resource_name=$( keylookup appin_name )

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
echo " Setting up Azure Function RBACS for group: "$group_name", type "$azf_resource_type" and name "$azf_resource_name" "
sh "$mod_dir"/setup.sh "$group_type" "$group_name" "$group_role" "$azf_resource_type" "$azf1_resource_name"
sh "$mod_dir"/setup.sh "$group_type" "$group_name" "$group_role" "$azf_resource_type" "$azf2_resource_name"
sh "$mod_dir"/setup.sh "$group_type" "$group_name" "$group_role" "$azf_resource_type" "$azf3_resource_name"
sh "$mod_dir"/setup.sh "$group_type" "$group_name" "$group_role" "$azf_resource_type" "$azf4_resource_name"

sh "$mod_dir"/setup.sh "$group_type" "$group_name" "$group_role" "$asp_resource_type" "$asp_resource_name"
sh "$mod_dir"/setup.sh "$group_type" "$group_name" "$group_role" "$appin_resource_type" "$appin_resource_name"

### add RBAC setup for dsp-jenkins-device service principal
echo " Setting up Azure Function RBACS for group: "$sp_name", type "$azf_resource_type" and name "$azf_resource_name" "
sh "$mod_dir"/setup.sh "$sp_type" "$sp_name" "$sp_role" "$azf_resource_type" "$azf1_resource_name"
sh "$mod_dir"/setup.sh "$sp_type" "$sp_name" "$sp_role" "$azf_resource_type" "$azf2_resource_name"
sh "$mod_dir"/setup.sh "$sp_type" "$sp_name" "$sp_role" "$azf_resource_type" "$azf3_resource_name"
sh "$mod_dir"/setup.sh "$sp_type" "$sp_name" "$sp_role" "$azf_resource_type" "$azf4_resource_name"

sh "$mod_dir"/setup.sh "$sp_type" "$sp_name" "$sp_role" "$asp_resource_type" "$asp_resource_name"
sh "$mod_dir"/setup.sh "$sp_type" "$sp_name" "$sp_role" "$appin_resource_type" "$appin_resource_name"

### add RBAC setup for user assigned managed identity
echo " Setting up Azure Function RBACS for group: "$uami_name", type "$azf_resource_type" and name "$azf_resource_name" "
sh "$mod_dir"/setup.sh "$uami_type" "$uami_name" "$uami_role" "$azf_resource_type" "$azf1_resource_name"
sh "$mod_dir"/setup.sh "$uami_type" "$uami_name" "$uami_role" "$azf_resource_type" "$azf2_resource_name"
sh "$mod_dir"/setup.sh "$uami_type" "$uami_name" "$uami_role" "$azf_resource_type" "$azf3_resource_name"
sh "$mod_dir"/setup.sh "$uami_type" "$uami_name" "$uami_role" "$azf_resource_type" "$azf4_resource_name"

sh "$mod_dir"/setup.sh "$uami_type" "$uami_name" "$uami_role" "$asp_resource_type" "$asp_resource_name"
sh "$mod_dir"/setup.sh "$uami_type" "$uami_name" "$uami_role" "$appin_resource_type" "$appin_resource_name"

echo " Azure Function RBAC Setup Done ... "