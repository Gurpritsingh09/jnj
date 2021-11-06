az_client_id=$3
az_client_secret=$4
az_tenant_id=$5
az_subs_id=$6

az login --service-principal -u $az_client_id -p $az_client_secret -t $az_tenant_id && az account set --subscription $az_subs_id
#Create Resource Group for storage account to store state files
resourcegroup_name="EUN-DS-QA-STG-TF"
resourcegroup_location="northeurope"

stg_name="eunqaterraformsta"
stg_resourcegroup="EUN-DS-QA-STG-TF"
stg_sku="Standard_LRS"
stg_kind="StorageV2"
stg_tls="TLS1_2"
container_name="qa-deployment"

#check if Resource group exists
rg_exists=$(az group exists --name $resourcegroup_name)

if [ "$rg_exists" = true ]; then
    echo "resource group $resourcegroup_name exists already"
    exit 1
else
    #create resource group
    az group create -l $resourcegroup_location -n $resourcegroup_name
    
    #Create storage account
    az storage account show --name $stg_name || az storage account create --name $stg_name --resource-group $stg_resourcegroup --kind $stg_kind --sku $stg_sku --min-tls-version $stg_tls
    az storage container show -n $container_name --account-name $stg_name --resource-group $stg_resourcegroup  || az storage container create -n $container_name --account-name $stg_name --resource-group $stg_resourcegroup
fi