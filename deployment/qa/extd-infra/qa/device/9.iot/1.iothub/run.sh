# Create IOT HUB
terraform init -backend-config=backend.hcl
terraform plan -out=execution-plan.plan -var-file=input.tfvars
terraform apply execution-plan.plan
