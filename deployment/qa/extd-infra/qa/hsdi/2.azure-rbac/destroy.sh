# Destroy Azure RBACs DSP
terraform init -backend-config=backend.hcl
terraform destroy -auto-approve
