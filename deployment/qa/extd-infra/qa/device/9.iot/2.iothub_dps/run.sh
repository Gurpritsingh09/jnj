# Create IOT HUB
terraform init -backend-config=backend.hcl
terraform plan -var-file=input.tfvars -out=execution-plan.plan
terraform apply execution-plan.plan
