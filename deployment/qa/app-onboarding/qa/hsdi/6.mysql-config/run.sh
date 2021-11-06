#!/bin/bash

az_client_id=$1
az_client_secret=$2
az_tenant_id=$3
az_subs_id=$4

set -e
chmod +x ./dicomdbqa/run.sh
./dicomdbqa/run.sh "$az_client_id" "$az_client_secret" "$az_tenant_id" "$az_subs_id"

