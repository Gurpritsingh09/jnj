# to destroy all DSP base resources 

kwd="`pwd`"
cd "$kwd"/15.diag-stg-nw-restriction
source destroy.sh
cd "$kwd"/14.private-dns-zone
source destroy.sh
cd "$kwd"/13.security-center
source destroy.sh
cd "$kwd"/12.appgwy
source destroy.sh
cd "$kwd"/11.acr
source destroy.sh
cd "$kwd"/10.firewall-rules
source destroy.sh
cd "$kwd"/9.loganalyticsws
source destroy.sh
cd "$kwd"/8.firewall
source destroy.sh
cd "$kwd"/7.keyvault
source destroy.sh
cd "$kwd"/6.networking
source destroy.sh
cd "$kwd"/15.diag-stg-nw-restriction
source destroy.sh
cd "$kwd"/4.public-ip
source destroy.sh
cd "$kwd"/3.azure-rbac
source destroy.sh
cd "$kwd"/2.azureadgroups
source destroy.sh
cd "$kwd"/1.resource-groups
source destroy.sh
