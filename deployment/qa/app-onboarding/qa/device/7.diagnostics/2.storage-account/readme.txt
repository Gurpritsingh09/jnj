terraform init -backend-config=backend_example.hcl
terraform plan -var-file=input.tfvars
terraform apply -var-file=input.tfvars
terraform destroy -var-file=input.tfvars
