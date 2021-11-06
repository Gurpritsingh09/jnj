# Create Resources for QA

echo " Starting QA resource deployment $1"

specific_resource_dir=$1
kwd="`pwd`"
base_infra_dir="qa/base-infra/qa"
adv_infra_dir="$kwd"/"qa/adv-infra/qa"
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


if [[ -d "$base_infra_dir" ]]
then
    echo "inside base infra"
    cd "$base_infra_dir"
    source run.sh
else
    echo "Please verify if $base_infra_dir exists?"
fi

if  [ "$include_adv_infra" == "true" ] && [ -d "$adv_infra_dir" ] 
then
      echo " Inside Adv Infra at : $adv_infra_dir "
      cd "$adv_infra_dir"
      source run.sh
else
      echo "Check if  Adv Infra Flag was set , if yes -> $adv_infra_dir does not exist. Please contact Terraform Team"
fi
