# Create Resources for QA

echo " Starting QA resource deployment $1"

kwd="`pwd`"
base_infra_dir="qa/base-infra/qa"
adv_infra_dir="$kwd"/"qa/adv-infra/qa"
app_name=$1
#airflow
app_specific_dir="$kwd"/"qa/app-onboarding/qa"/$app_name
include_adv_infra=$2  # True : setup advance infra , False : default to base infra only


echo " Inside App Specific Infra at $app_specific_dir"
cd "$app_specific_dir"


source run.sh $3 $4 $5 $6 
echo "Status = $?"
