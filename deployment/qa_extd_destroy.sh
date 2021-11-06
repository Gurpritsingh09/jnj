
echo " Starting QA extd-infra resource destroy $1"

kwd="`pwd`"
resource=$1

extd_infra="$kwd"/"qa/extd-infra/qa"/$resource


echo "Inside extended infra at $extd_infra"
cd "$extd_infra"


source destroy.sh
echo "Status = $?"