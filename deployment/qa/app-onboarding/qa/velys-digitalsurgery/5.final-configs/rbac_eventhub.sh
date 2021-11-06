# RBAC Eventhub deployment file for App 

#import keylookup function script to retrieve values from config.properties 
mod_dir_function="../../../../../../post-provision/key-lookup-function"

chmod +x "$mod_dir_function"/keylookup.sh
. "$mod_dir_function"/keylookup.sh

eh_group_type=$( keylookup user_group_type )
eh_group_name=$( keylookup team_name )
role_reader=$( keylookup role_reader )

eh_resource_type=$( keylookup resource_type_eventhub )
eh_resource_name1=$( keylookup eventhub_name1 )
eh_resource_name2=$( keylookup eventhub_name2 )

eh_sp_type=$( keylookup user_sp_type )
sp_name=$( keylookup sp_name )
role_contributor=$( keylookup role_contributor )
eventhub_role_data_sender=$( keylookup eventhub_role_data_sender )
eventhub_role_data_receiver=$( keylookup eventhub_role_data_receiver )


mod_dir="../../../../../../post-provision/rbacs"


#First Eventhub
echo " Setting up Eventhub RBACS for group: "$eh_group_name", role: "$role_reader", type: "$eh_resource_type" and name "$eh_resource_name1" "
sh "$mod_dir"/setup.sh "$eh_group_type" "$eh_group_name" "$role_reader" "$eh_resource_type" "$eh_resource_name1" 

echo " Setting up Eventhub RBACS for service prinicipal: "$sp_name", role: "$role_contributor", type "$eh_resource_type" and name "$eh_resource_name1" "
sh "$mod_dir"/setup.sh "$eh_sp_type" "$sp_name" "$role_contributor" "$eh_resource_type" "$eh_resource_name1"

echo " Setting up Eventhub RBACS for service prinicipal: "$sp_name", role: "$eventhub_role_data_sender", type "$eh_resource_type" and name "$eh_resource_name1" "
sh "$mod_dir"/setup.sh "$eh_sp_type" "$sp_name" "$eventhub_role_data_sender" "$eh_resource_type" "$eh_resource_name1"

echo " Setting up Eventhub RBACS for service prinicipal: "$sp_name", role: "$eventhub_role_data_receiver", type "$eh_resource_type" and name "$eh_resource_name1" "
sh "$mod_dir"/setup.sh "$eh_sp_type" "$sp_name" "$eventhub_role_data_receiver" "$eh_resource_type" "$eh_resource_name1"

#Second EventHub
echo " Setting up Eventhub RBACS for group: "$eh_group_name", role: "$role_reader", type: "$eh_resource_type" and name "$eh_resource_name2" "
sh "$mod_dir"/setup.sh "$eh_group_type" "$eh_group_name" "$role_reader" "$eh_resource_type" "$eh_resource_name2" 

echo " Setting up Eventhub RBACS for service prinicipal: "$sp_name", role: "$role_contributor", type "$eh_resource_type" and name "$eh_resource_name2" "
sh "$mod_dir"/setup.sh "$eh_sp_type" "$sp_name" "$role_contributor" "$eh_resource_type" "$eh_resource_name2"

echo " Setting up Eventhub RBACS for service prinicipal: "$sp_name", role: "$eventhub_role_data_sender", type "$eh_resource_type" and name "$eh_resource_name2" "
sh "$mod_dir"/setup.sh "$eh_sp_type" "$sp_name" "$eventhub_role_data_sender" "$eh_resource_type" "$eh_resource_name2"

echo " Setting up Eventhub RBACS for service prinicipal: "$sp_name", role: "$eventhub_role_data_receiver", type "$eh_resource_type" and name "$eh_resource_name2" "
sh "$mod_dir"/setup.sh "$eh_sp_type" "$sp_name" "$eventhub_role_data_receiver" "$eh_resource_type" "$eh_resource_name2"


echo " Eventhub RBAC Setup Done ... "
