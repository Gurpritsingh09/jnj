# RBAC FileShare deployment file for App

#import keylookup function script to retrieve values from config.properties
mod_dir_function="../../../../../../post-provision/key-lookup-function"

chmod +x "$mod_dir_function"/keylookup.sh
. "$mod_dir_function"/keylookup.sh

fs_group_type=$(keylookup user_group_type)
fs_group_name=$(keylookup team_name)
role_reader=$(keylookup role_reader)

fs_resource_type=$(keylookup resource_type_storageaccount)
fs_resource_name=$(keylookup fileshare_storage_account)
fileshare_name_logs=$(keylookup fileshare_name_logs)

fs_sp_type=$(keylookup user_sp_type)
fs_sp_name=$(keylookup sp_name)
role_contributor=$(keylookup role_contributor)

mod_dir="../../../../../../post-provision/rbacs"

echo " Setting up fileshare RBACS for group: "$fs_group_name", role: "$role_reader", type: "$fs_resource_type", storage account: "$fs_resource_name" and fileshare: "$fileshare_name_logs" "
sh "$mod_dir"/setup.sh "$fs_group_type" "$fs_group_name" "$role_reader" "$fs_resource_type" "$fs_resource_name" "$fileshare_name_logs"

echo " Setting up fileshare RBACS for service prinicipal: "$fs_sp_name", role: "$role_contributor", type: "$fs_resource_type" storage account: "$fs_resource_name" and fileshare: "$fileshare_name_logs" "
sh "$mod_dir"/setup.sh "$fs_sp_type" "$fs_sp_name" "$role_contributor" "$fs_resource_type" "$fs_resource_name" "$fileshare_name_logs"



echo " FileShare RBAC Setup Done ... "
