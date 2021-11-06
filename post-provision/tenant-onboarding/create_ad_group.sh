ad_grp_prefix=`grep ad_grp_prefix ./config.properties | cut -d"=" -f2`
app_name=`grep app_name ./config.properties | cut -d"=" -f2`
team_prefix=`grep team_prefix ./config.properties | cut -d"=" -f2`

tenant_ad_group="$ad_grp_prefix-$team_prefix-$app_name"
echo " Tenant Group = $tenant_ad_group"
az ad group show --group $tenant_ad_group || ( echo "Creating AD group : $tenant_ad_group " && az ad group create --display-name $tenant_ad_group --mail-nickname $tenant_ad_group && echo "..........  Created AD group : $tenant_ad_group .........." )

