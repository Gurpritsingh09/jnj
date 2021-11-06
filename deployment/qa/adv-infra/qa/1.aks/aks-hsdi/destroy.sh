# Destroy AKS for QA only
terraform init -backend-config=backend.hcl
terraform destroy -auto-approve 
