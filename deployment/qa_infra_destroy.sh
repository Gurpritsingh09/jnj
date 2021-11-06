# Create Resources for QA

specific_resource_dir=$1
base_infra_dir="qa/base-infra/qa"
adv_infra_dir="qa/adv-infra/qa"
include_adv_infra=$2  # True : setup advance infra , False : default to base infra only

if [[ ! -z "$specific_resource_dir" ]] 
then
 if [ $specific_resource_dir == "ALL" ] 
 then
  run_all=1
 else
  base_infra_dir=$base_infra_dir/$specific_resource_dir
  adv_infra_dir=$adv_infra_dir/$specific_resource_dir
 fi
fi



if  [ "$include_adv_infra" == "true" ] && [ -d "$adv_infra_dir" ] 
then
      cd $adv_infra_dir
      source destroy.sh
else
      echo "Check if  Adv Infra Flag was set , if yes -> $adv_infra_dir does not exist. Please contact Terraform Team"
fi


if [[ -d "$base_infra_dir" ]]
then
    cd $base_infra_dir
    source destroy.sh
else
    echo "Please verify if $base_infra_dir exists?"
fi



