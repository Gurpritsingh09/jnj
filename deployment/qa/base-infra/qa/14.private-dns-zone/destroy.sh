# Destroy Private DNS Zone

terraform init -backend-config=backend.hcl
terraform destroy -var-file=input.tfvars -auto-approve 
