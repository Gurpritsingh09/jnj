provider "azurerm" {
  # Allow any 2.x version of the AWS provider
  version = "~> 2.13.0"
  features {}
}

provider "azuread" {
  version = "~>0.8.0"
}

# will be enabled for resource provisioning
terraform {
  backend "azurerm" {}
}
