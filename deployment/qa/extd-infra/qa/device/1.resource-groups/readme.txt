# Deployment for Resource Groups for DSP - SBX only

terraform init -backend-config=backend.hcl
terraform plan -var-file=input.tfvars
terraform apply -var-file=input.tfvars
#terraform destroy -var-file=input.tfvars

