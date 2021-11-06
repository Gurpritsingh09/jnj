# Option 1 : to use with input.tfvars & variables.tf, -> Input values are not supplied in main.tf
terraform init -backend-config=backend_example.hcl
terraform plan -var-file=input.tfvars
terraform apply -var-file=input.tfvars
terraform destroy -var-file=input.tfvars

# Option 2: to use without input.tfvars & variables.tf -> Input values must be supplied in main.tf
terraform init -backend-config=backend_example.hcl
terraform plan 
terraform apply
terraform destroy
