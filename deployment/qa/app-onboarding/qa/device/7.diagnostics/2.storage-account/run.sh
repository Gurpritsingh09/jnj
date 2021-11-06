# Deployment of Storageaccount for DSP
kwd="$(pwd)"
cd "$kwd/storage-account-extended-diagnostics"
. ./run.sh

cd $kwd

terraform init -backend-config=backend.hcl
terraform plan -var-file=input.tfvars
terraform apply -var-file=input.tfvars -auto-approve
