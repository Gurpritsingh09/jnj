#!bin/bash

echo "Entered into Storage-Account-Logging Setup"

sa_name="$1"
# sa_rg="$2"

if [ -z "$1" ]
then
    echo "Storage account Name is empty, sa_name: $sa_name "
    exit 1 
else
    #connection_string=$(az storage account show-connection-string --name "$sa_name" --resource-group "$sa_rg" --query connectionString | tr -d '"')
    echo " Enabling Hour Metrics and logging for storage account: $sa_name "
    az storage logging update --log "rwd" --retention "90" --services "bq" --account-name "$sa_name" --version "2.0" #--connection-string "$connection_string"
    az storage logging update --log "rwd" --retention "90" --services "t" --account-name "$sa_name" --version "1.0" #--connection-string "$connection_string"
    az storage metrics update --retention "90" --services "bfqt" --hour "true" --api "true" --account-name "$sa_name"
fi

echo " Done with Storage-Account-Logging setup "