# Generic Routine to add initial supplied members to a Tenant group

ad_grp_prefix=`grep ad_grp_prefix ./config.properties | cut -d"=" -f2`
app_name=`grep app_name ./config.properties | cut -d"=" -f2`
team_prefix=`grep team_prefix ./config.properties | cut -d"=" -f2`

tenant_ad_group="$ad_grp_prefix-$team_prefix-$app_name"

tenant_ad_group_id=`az ad group list --filter "displayname eq '$tenant_ad_group'" | jq -r ' .[].objectId '`

cluster_admins_grp=$1
spn_name=$2

if [ -z "$tenant_ad_group_id" ]
then
	echo " Sorry Application/Tenant Group : $tenant_ad_group not found "
	exit 1
fi

echo " Initializing Membership against Group :  $tenant_ad_group "

members="./tenant-members.properties"

while IFS= read -r user_email
do
	member_id=`az ad user list --upn "$user_email" | jq -r '.[].objectId' `

        if [ ! -z "$member_id" ] #check if member_id is NOT null
        then
	  echo " Adding member : $user_email with member id : $member_id  to group $tenant_ad_group"
	  az ad group member add --group "$tenant_ad_group" --member-id "$member_id"
	else
	  echo "Sorry !!    member : $user_email is not found"
        fi

done < "$members"


# Add Tenant Group to established AD groups (created as part of Environment Provisioning )


env_groups="./env-groups.properties"
while IFS= read -r existing_ad_group
do
	echo "Adding $tenant_ad_group to group $existing_ad_group "	
	az ad group member add --group "$existing_ad_group" --member-id "$tenant_ad_group_id"

done < "$env_groups"

# Add AppTeam SPN to "Cluster-Admin"  - part of AKS rbac 
cluster_admin_grp=$1

echo " Adding $spn_name to  $cluster_admin_grp "
spn_id=`az ad sp list --filter "displayname eq '$spn_name'" | jq -r '.[].objectId'`
az ad group member add --group "$cluster_admin_grp" --member-id "$spn_id"

echo " Initalization Complete .... "

