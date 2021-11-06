nw_resource_group=$1
fw_public_ip_name=$2
dns_zone=$3
dns_record_set=$4
cluster_ingress_ip=$5
pvt_dns_rg=$6

fw_public_ip=`az network public-ip show -g "$nw_resource_group" -n "$fw_public_ip_name" | jq -r '.ipAddress'`

echo " Adding Record Set in DNS Zone : $dns_zone "
az network dns record-set a add-record -g "$nw_resource_group" -z "$dns_zone"  -n "*.$dns_record_set" -a "$fw_public_ip"

echo " Adding Record Set in Private DNS Zone : $dns_zone "
az network private-dns record-set a add-record -g "$pvt_dns_rg" -z "$dns_zone"  -n "*.$dns_record_set" -a "$cluster_ingress_ip"
