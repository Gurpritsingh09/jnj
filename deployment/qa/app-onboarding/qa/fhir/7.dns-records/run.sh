az_client_id=$1
az_client_secret=$2
az_tenant_id=$3
az_subs_id=$4

az login --service-principal -u $az_client_id -p $az_client_secret -t $az_tenant_id && az account set --subscription $az_subs_id
mod_dir_function="../../../../../../post-provision/key-lookup-function"

chmod +x "$mod_dir_function"/keylookup.sh
. "$mod_dir_function"/keylookup.sh


dns_zone=$( keylookup "dns_zone" )
cluster_ingress_ip=$( keylookup "cluster_ingress_ip" )
pvt_dns_rg=$( keylookup "nw_rg" )

dns_record_set="`grep $cluster_name ./cluster-ingress.properties | cut -d"=" -f3`"

mod_dir="../../../../../../post-provision/dns-a-record-setup"
chmod +x "$mod_dir"/setup_v2.sh

dns_record_set=$( keylookup "cluster_web_prefix" )
echo " Starting DNS A Records: $dns_record_set  Addition to $dns_zone "

./"$mod_dir/"setup_v2.sh $dns_zone $pvt_dns_rg $dns_record_set $cluster_ingress_ip

dns_record_set=$( keylookup "cluster_api_prefix" )
echo " Starting DNS A Records: $dns_record_set  Addition to $dns_zone "

./"$mod_dir/"setup_v2.sh $dns_zone $pvt_dns_rg $dns_record_set $cluster_ingress_ip