# Destroy Resource Groups for DSP - Shared NPD

terraform init -backend-config=backend.hcl
terraform destroy -var-file=input.tfvars  -auto-approve 
