data "azurerm_virtual_network" "vn" {
  for_each            = { for link in var.zone_to_vnet_links : link.vn_name => link }
  name                = each.value["vn_name"]
  resource_group_name = each.value["vn_rg"]
}
