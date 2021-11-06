# Deployment of Storage Account for DSP

terraform init -backend-config=backend.hcl
terraform plan -var-file=input.tfvars -out=execution-plan.plan
terraform apply execution-plan.plan

az login --service-principal --username $ARM_CLIENT_ID --password $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID && az account set --subscription $ARM_SUBSCRIPTION_ID
python generate-sas.py -a dsqastgredox -c from-redox

# sh restrict-access.sh
# terraform apply -var-file=input.tfvars  -auto-approve -var restrict_public_access=true

terraform apply -var-file=input.tfvars  -auto-approve -var restrict_public_access=true
az logout