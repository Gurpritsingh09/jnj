# Provision All Advanced Infra resources for DEV

kwd="`pwd`"

cd "$kwd"/0.additional_subnets
source run.sh
cd "$kwd"/1.aks/aks-microservices
source run.sh
cd "$kwd"/1.aks/aks-fhr
source run.sh
cd "$kwd"/1.aks/aks-airflow-nifi
source run.sh
cd "$kwd"/1.aks/aks-hsdi
source run.sh
cd "$kwd"/2.eventhub/eventhub-npdtqa-velysinsights
source run.sh
cd "$kwd"/2.eventhub/dspehubvelysrsk01qa
source run.sh
cd "$kwd"/2.eventhub/dspehubvelysrsk02qa
source run.sh
cd "$kwd"/3.db/mysql-airflow-metadata
source run.sh
cd "$kwd"/3.db/mysql-fhir
source run.sh
cd "$kwd"/3.db/mysql-mysql-shareddb
source run.sh
cd "$kwd"/4.service-principal
source run.sh
cd "$kwd"/5.diagnostics/1.aks
source run.sh
