# Destroy of ACR for DSP

terraform init -backend-config=backend.hcl

terraform destroy -var-file=input.tfvars -target=module.PrivateEndpoint.module.PrivateDNSARecord -auto-approve
terraform destroy -var-file=input.tfvars -target=module.PrivateEndpoint.module.PrivateDNSZone -auto-approve
terraform destroy -var-file=input.tfvars -target=module.PrivateEndpoint.azurerm_private_endpoint.this -auto-approve
#terraform destroy -var-file=input.tfvars -target=module.ContainerRegistry -auto-approve
terraform destroy -var-file=input.tfvars -auto-approve