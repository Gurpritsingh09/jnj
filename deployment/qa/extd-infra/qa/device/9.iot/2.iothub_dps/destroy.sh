# Destroy IOT HUB for SBX only
terraform init -backend-config=backend.hcl
terraform destroy  -var-file=input.tfvars  -auto-approve