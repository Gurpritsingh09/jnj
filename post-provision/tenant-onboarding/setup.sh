# Master script to invoke necessary sub-scripts as per demand

cluster_name=$1
spn_name=$2

source create_ad_group.sh
#source initialize_tenant_group.sh $cluster_name $spn_name
