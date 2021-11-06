# RBAC Storageaccount deployment file for App

#import keylookup function script to retrieve values from config.properties
mod_dir_function="../../../../../../post-provision/key-lookup-function"

chmod +x "$mod_dir_function"/keylookup.sh
. "$mod_dir_function"/keylookup.sh

fs_group_type=$(keylookup user_group_type)
fs_group_name=$(keylookup team_name)
role_readanddata=$(keylookup role_readanddata)

fs_resource_type=$(keylookup resource_type_storageaccount)
fs_resource_name=$(keylookup storage_account_name)

fs_sp_type=$(keylookup user_sp_type)
fs_sp_name=$(keylookup sp_name)
role_contributor=$(keylookup role_contributor)
sbdc_role=$(keylookup sbdc_role)

mod_dir="../../../../../../post-provision/rbacs"

for sa_name in $(echo $fs_resource_name | sed "s/,/ /g"); do
    echo " Setting up Storageaccount RBACS for group: "$fs_group_name", role: "$role_readanddata", type: "$fs_resource_type", storage account: "$sa_name" "
    sh "$mod_dir"/setup.sh "$fs_group_type" "$fs_group_name" "$role_readanddata" "$fs_resource_type" "$sa_name"

    echo " Setting up Storageaccount RBACS for service prinicipal: "$fs_sp_name", role: "$role_contributor", type: "$fs_resource_type" storage account: "$sa_name""
    sh "$mod_dir"/setup.sh "$fs_sp_type" "$fs_sp_name" "$role_contributor" "$fs_resource_type" "$sa_name"

    echo " Setting up Storage Blob Data Contributor RBACS for service prinicipal: "$fs_sp_name", role: "$sbdc_role", type: "$fs_resource_type" storage account: "$sa_name""
    sh "$mod_dir"/setup.sh "$fs_sp_type" "$fs_sp_name" "$sbdc_role" "$fs_resource_type" "$sa_name"
done

echo " Storageaccount RBAC Setup Done ... "
