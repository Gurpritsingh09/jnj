# Deployment of Storage Account for DSP

terraform init -backend-config=backend.hcl
terraform plan -var-file=input.tfvars
terraform apply -var-file=input.tfvars  -auto-approve
# terraform apply -var-file=input.tfvars  -auto-approve -var restrict_public_access=true
