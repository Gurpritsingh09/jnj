# Create Resources for QA

echo " Starting QA resource deployment : $1"

kwd="`pwd`"
post_provision_infra_dir="qa/post-provision/qa"
provision_resource_name=$1
#airflow
specific_dir="$kwd/$post_provision_infra_dir/$provision_resource_name"


echo " Inside Dir $specific_dir"
cd "$specific_dir"
source run.sh $3 $4 $5 $6 
echo "Status = $?"
