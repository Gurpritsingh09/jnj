# Destroy Azure AD groups DSP

terraform init -backend-config=backend.hcl
terraform destroy -var-file=input.tfvars  -auto-approve
