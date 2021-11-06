tenant_ad_group=$1

echo " Tenant Group = $tenant_ad_group"
az ad group show --group $tenant_ad_group || ( echo "Creating AD group : $tenant_ad_group " && az ad group create --display-name $tenant_ad_group --mail-nickname $tenant_ad_group && echo "..........  Created AD group : $tenant_ad_group .........." )