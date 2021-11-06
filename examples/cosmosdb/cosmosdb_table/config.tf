provider "azurerm" {
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
