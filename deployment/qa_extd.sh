echo " Starting QA resource deployment $1"

kwd="`pwd`"
resource=$1

extd_infra="$kwd"/"qa/extd-infra/qa"/$resource

echo "Inside extended infra at $extd_infra"
cd "$extd_infra"

./run.sh $3 $4 $5 $6
#source run.sh $3 $4 $5 $6
echo "Status = $?"