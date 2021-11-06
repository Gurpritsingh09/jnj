# Create Azure RBACs DSP
terraform init -backend-config=backend.hcl
terraform plan
terraform apply -auto-approve
