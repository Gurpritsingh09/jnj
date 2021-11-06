# to provision all DSP resources 
# to add new resource, add its entries to the list below

kwd="`pwd`"

echo " == Creating Resource Groups == "
cd "$kwd"/1.resource-groups
source run.sh
echo " == Creating Azure AD Groups == "
cd "$kwd"/2.azureadgroups
source run.sh
echo " == Creating Azure RBACs == "
cd "$kwd"/3.azure-rbac
source run.sh
echo " == Creating Public IP == "
cd "$kwd"/4.public-ip
source run.sh
echo " == Creating Storage Account == "
cd "$kwd"/5.storageaccount
source run.sh
#sleep 300
echo " == Creating Network == "
cd "$kwd"/6.networking
#sleep 420
source run.sh
echo " == Creating Keyvault == "
cd "$kwd"/7.keyvault
source run.sh
#sleep 180
echo " == Creating Firewall == "
cd "$kwd"/8.firewall
source run.sh
echo " == Creating Log Analytics Workspace == "
cd "$kwd"/9.loganalyticsws
source run.sh
echo " == Creating Firewall Rules == "
cd "$kwd"/10.firewall-rules
source run.sh
echo " == Creating ACR == "
cd "$kwd"/11.acr
source run.sh
echo " == Creating Application Gateway == "
cd "$kwd"/12.appgwy
source run.sh
echo " == Creating Security Center == "
cd "$kwd"/13.security-center
source run.sh
echo " == Creating Private DNS Zone thesurgicalnet.com == "
cd "$kwd"/14.private-dns-zone
source run.sh
echo " == Updating Diag Storage Account == "
cd "$kwd"/15.diag-stg-nw-restriction
source run.sh
