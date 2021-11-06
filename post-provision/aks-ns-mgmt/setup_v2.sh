#!/bin/bash

#Master script to configure a new namespace on a given Cluster

cluster_name=$1
cluster_rg=$2
namespace_file=$3  # Full Path of Namespace File containing namespaces to be managed
azure_ad_namespace_admin_group=$4

az aks get-credentials --resource-group $cluster_rg --name $cluster_name --admin

#create app namespace

input=$namespace_file

## Let us read a file line-by-line using while loop ##
while IFS= read -r namespace_name
do
    
    echo " Namespace : $namespace_name processing started"
    
    #azure_ad_namespace_admin_group="$cluster_name-$namespace_name-Admins"
    
    
    
    az ad group show --group $azure_ad_namespace_admin_group || az ad group create --display-name $azure_ad_namespace_admin_group --mail-nickname $azure_ad_namespace_admin_group
    
    ad_group_id=`az ad group show --group $azure_ad_namespace_admin_group | jq -r .objectId`
    
    if [  -z $ad_group_id ]
    then
        echo " AD Group $azure_ad_namespace_admin_group could not be created/retrieved. Please check with Infra Team"
        exit 1
    fi
    rm -f ./role.yaml
    rm -f ./rolebinding.yaml
    # Prepare Role YAML
    namespace_admin_role="$namespace_name-admin-role"
    echo "Preparing role.yaml for $namespace_admin_role"
    cp templates/role.yaml role.yaml
    sed -i s/"<namespace-admin-role>"/"$namespace_admin_role"/ role.yaml
    sed -i s/"<namespace_name>"/"$namespace_name"/ role.yaml
    
    echo "Prepared role.yaml for $namespace_admin_role"
    # Prepare RoleBinding YAML
    namespace_admin_role="$namespace_name-admin-role"
    namespace_admin_role_binding="$namespace_admin_role-binding"
    azure_ns_admin_group_object_id="$ad_group_id"
    echo "Preparing rolebinding.yaml for $namespace_admin_role"
    
    cp templates/rolebinding.yaml rolebinding.yaml
    
    sed -i s/"<namespace-admin-role>"/"$namespace_admin_role"/ rolebinding.yaml
    sed -i s/"<namespace_name>"/"$namespace_name"/ rolebinding.yaml
    sed -i s/"<namespace-admin-role-binding>"/"$namespace_admin_role_binding"/ rolebinding.yaml
    sed -i s/"<azure-ns-admin-group-object-id>"/"$azure_ns_admin_group_object_id"/ rolebinding.yaml
    
    echo "Prepared rolebinding.yaml for $namespace_admin_role"
    
    #Check if NAMESPACE already exists, if not then create namespace
    echo "================   Creating namespace : $namespace_name if it does not exist  ================================ "
    
    kubectl get ns $namespace_name || kubectl create ns $namespace_name && kubectl apply -f role.yaml && kubectl apply -f rolebinding.yaml
    
    #copy ssl-cert & secret to the new ns
    
    echo " =============== Copying TLS secret 'ingress-tls-ssl' from ingress-basic to namespace : $namespace_name =================  "
    
    kubectl get secret ingress-tls-ssl -n ingress-basic
    
    kubectl describe secret ingress-tls-ssl -n $namespace_name || kubectl get secret ingress-tls-ssl -n ingress-basic -o yaml | sed s/"namespace: ingress-basic"/"namespace: $namespace_name"/ | kubectl apply -n $namespace_name -f -
    
    echo " Namespace : $namespace_name processing finished"
done < "$input"

echo " Wait for 30s "
sleep 30s