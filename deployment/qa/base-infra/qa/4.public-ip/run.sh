# Create Public IPs for NPD 
terraform init -backend-config=backend.hcl
terraform plan 
terraform apply -auto-approve
