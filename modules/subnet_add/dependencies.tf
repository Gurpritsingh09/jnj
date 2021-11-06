
data "azurerm_resource_group" "vnet" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  for_each            = var.virtual_networks
  name                = each.value["name"]
  resource_group_name = var.resource_group_name
}

data "azurerm_route_table" "rt" {
  for_each            = var.route_tables
  name                = each.value["name"]
  resource_group_name = var.resource_group_name
}
