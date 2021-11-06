# Deployment for Resource Groups for DSP

terraform init -backend-config=backend.hcl
terraform plan -var-file=input.tfvars
terraform apply -var-file=input.tfvars
#terraform destroy -var-file=input.tfvars

