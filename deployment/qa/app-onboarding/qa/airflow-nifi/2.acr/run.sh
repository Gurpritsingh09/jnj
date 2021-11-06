terraform init -backend-config=backend.hcl
terraform apply -var-file=input.tfvars -target=module.ContainerRegistry -auto-approve
terraform apply -var-file=input.tfvars -target=module.PrivateEndpoint.azurerm_private_endpoint.this -auto-approve
terraform apply -var-file=input.tfvars -auto-approve