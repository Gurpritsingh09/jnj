provider "azurerm" {
  features {}
}

#provider "azuread" {
#}

provider "azuread" {

  version ="~>0.8.0"

}

terraform {
  backend "azurerm" {
  }
}
