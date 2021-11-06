#!/bin/bash

function mysqlsetup() {

    azure_mysql_service=$1
    app_dbname=$2
    app_dbuser=$3
    appteam_name=$4
    keyvault_name=$5
    mod_dir=$6
    dbadmin_user=$7
    group_name=$8
    sql_path="$9"
    random_password=$(date +%s | sha256sum | base64 | head -c 32)
    #CHECK IF SQL_PATH was set
    if [ ! -z "${sql_path}" ]; then
        mod_dir="$sql_path"
    fi
    admin_password=$(az keyvault secret show --name $dbadmin_user --vault-name ${keyvault_name} | jq -r ' .value ') >log.txt
    #MAKE APPTEAM UPPERCASE
    appteam_name_formatted=$(echo "${appteam_name^^}")
    group_name_formatted=$(echo "${group_name^^}")
    aadgroup_formatted="$group_name_formatted-$appteam_name_formatted"
    app_dbuser_formatted=${app_dbuser//[^[:alnum:]]/}

    secret_exists=$(az keyvault secret show --name "${app_dbuser_formatted}" --vault-name ${keyvault_name} --query value) >>log.txt

    if [ -z $secret_exists ]; then
        az login -u "$dbadmin_user@surgicalnet.io" -p "$admin_password" >>log.txt
        mysql -h $azure_mysql_service.mysql.database.azure.com \
            --user "$dbadmin_user"@surgicalnet.io@$azure_mysql_service \
            --enable-cleartext-plugin \
            --password=$(az account get-access-token --resource-type oss-rdbms --output tsv --query accessToken) -e \
            "SET @dbname='$app_dbname';\
        SET @dbuser='$app_dbuser';\
        SET @password='$random_password';\
        SET @aaduser='$aadgroup_formatted';\
        SET @appteam='$appteam_name_formatted';\
        $(cat "$mod_dir"/db-user-creation.sql)" >>log.txt
        if [ $? == 1 ]; then
            exit 1
        fi
        mysql -h $azure_mysql_service.mysql.database.azure.com \
            --user "$dbadmin_user"@surgicalnet.io@$azure_mysql_service \
            --enable-cleartext-plugin \
            --password=$(az account get-access-token --resource-type oss-rdbms --output tsv --query accessToken) -e \
            "SET @dbname='$app_dbname';\
        SET @dbuser='$app_dbuser';\
        SET @appteam='$aadgroup_formatted';\
        $(cat "$mod_dir"/db-permissions.sql)" >>log.txt
        if [ $? == 1 ]; then
            exit 1
        fi
        az logout
        echo $random_password
    else
        echo 0
    fi

}
