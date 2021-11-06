provider "azurerm" {
  features {}
}

provider "azuread" {
  version = "~>0.8.0"
}

terraform {
  backend "azurerm" {
  }
}
