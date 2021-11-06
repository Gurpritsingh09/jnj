#!/bin/bash

#Master script to setup NGNIX on a given Cluster

echo " Entered into NGNIX Setup " 

cluster_name=$1
cluster_rg=$2
dns_zone_name=$3
dns_zone_rg=$4
keyvault=$5

cert_password=$(az keyvault secret show \
  --name "app-gwy-cert-admin" \
  --vault-name $keyvault \
  --query value \
  --output tsv)


#pre-requisites setup
cluster_prefix=`grep $cluster_name ./cluster-ingress.properties | cut -d"=" -f3`
cluster_ingress_ip=`grep $cluster_name ./cluster-ingress.properties | cut -d"=" -f2`

if [ -z "$cluster_prefix" ]
then
	echo " Sorry Cluster $cluster_name entries not found in cluster-ingress.properties "
	exit 0
fi


# Prepare YAML files

# a. prepare internal-ingress.yaml
 echo " Preparing internal-ingress.yaml ..... "
 cp templates/internal-ingress.yaml .
 sed -i s/"<cluster-ingress-ip>"/"$cluster_ingress_ip"/ internal-ingress.yaml
 echo " Prepared internal-ingress.yaml ..... "

#1. Connect to cluster
echo "Obtaining Cluster: $cluster_name Credentials"
az aks get-credentials --resource-group $cluster_rg --name $cluster_name --admin

echo " Obtained Cluster: $cluster_name Credentials"

#2. Create Namespace for Ingress
echo " Creating Namespace : ingress-basic" 
kubectl create namespace ingress-basic

#3. Setup Helm
echo "Setting up helm3 repo "
helm3 repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
echo "Installing ngnix-ingress from helm3 "
helm3 install nginx-ingress ingress-nginx/ingress-nginx \
    --namespace ingress-basic  \
    -f internal-ingress.yaml \
    --set controller.replicaCount=2 \
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --version 3.7.1

echo " nginx-ingress installed "
#sleep 75s

cnt=1

while [ $cnt -gt 0 ]
do
  echo "...Waiting 20s for Ingress Load Balancer to be ready with Public IP "
  sleep 20s
  cnt=`kubectl get svc -n ingress-basic | grep LoadBalancer| grep "<pending>" | wc -l`
done

# Print the published services from ingress-basic namespace
echo "Print K8S service ingress-basic "
kubectl get svc --namespace ingress-basic

kubectl create secret tls ingress-tls-ssl --namespace ingress-basic --key tls.key --cert tls.crt

 echo "NGNIX is configured on Cluster : $cluster_name"

