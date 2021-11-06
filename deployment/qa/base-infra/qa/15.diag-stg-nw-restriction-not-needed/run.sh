# Deployment of Diadnostics Storage Account for DSP

terraform init -backend-config=backend.hcl
terraform plan -var-file=input.tfvars
terraform apply -var-file=input.tfvars  -auto-approve 