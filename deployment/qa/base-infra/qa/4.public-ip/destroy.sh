# Destroy Public IPs for NPD 
terraform init -backend-config=backend.hcl
terraform destroy  -auto-approve
