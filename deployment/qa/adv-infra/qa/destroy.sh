# Destroy All Advanced Infra resources for SBX

kwd="`pwd`"

cd "$kwd"/5.diagnostics/1.aks
source destroy.sh
cd "$kwd"/4.service-principal
source destroy.sh
cd "$kwd"/3.db/mysql-shareddb
source destroy.sh
cd "$kwd"/3.db/mysql-fhir
source destroy.sh
cd "$kwd"/3.db/mysql-airflow-metadata
source destroy.sh
cd "$kwd"/2.eventhub/eventhub-npdtqa-velysinsights
source destroy.sh
cd "$kwd"/2.eventhub/dspehubvelysrsk02qa
source destroy.sh
cd "$kwd"/2.eventhub/dspehubvelysrsk01qa
source destroy.sh
cd "$kwd"/1.aks/aks-hsdi
source destroy.sh
cd "$kwd"/1.aks/aks-airflow-nifi
source destroy.sh
cd "$kwd"/1.aks/aks-qa
source destroy.sh
cd "$kwd"/1.aks/aks-fhr-qa
source destroy.sh
#cd $kwd/1.iot
#source destroy.sh


