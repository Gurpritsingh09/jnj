provider "azurerm" {
  # Allow any 2.x version of the AWS provider
  version = "~> 2.10"
  features {}
}

provider "azuread" {

  version ="~>0.8.0"

}

terraform {
  backend "azurerm" {
  }
}
