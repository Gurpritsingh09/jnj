data "azurerm_subnet" "subnet" {
  name                 = var.subnet-name
  resource_group_name  = var.network-rg
  virtual_network_name = var.vnet-name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet-name
  resource_group_name = var.network-rg
}

data "azurerm_application_insights" "this" {
  name                = var.appinsights-name
  resource_group_name = var.resource-group-name
}

data "azurerm_storage_account" "this" {
  name                = var.sa-name
  resource_group_name = var.sa-rg
}

data "azurerm_user_assigned_identity" "function-uaid" {
  name                = var.uaid-name
  resource_group_name = var.resource-group-name
}

data "azurerm_resource_group" "rg" {
  name = var.resource-group-name
}
