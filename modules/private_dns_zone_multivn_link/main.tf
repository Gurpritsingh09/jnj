data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

locals {
  parsed_vnet_links = distinct([for key, value in data.azurerm_virtual_network.vn : {
    vnet       = value,
    vnet_input = var.zone_to_vnet_links[index(var.zone_to_vnet_links.*.vn_name, key)]
  }])
}

# Private DNS Zone

resource "azurerm_private_dns_zone" "private_dns_zones" {
  name                = var.dns_zone_name
  resource_group_name = data.azurerm_resource_group.this.name
  tags                = var.tags
}

# Private DNS Zone to VNet Link

resource "azurerm_private_dns_zone_virtual_network_link" "dns_zones_virtul_network_links" {
  for_each              = { for link in local.parsed_vnet_links : link.vnet.id => link }
  name                  = substr("${each.value["vnet"]["name"]}-link", 0, 80)
  resource_group_name   = data.azurerm_resource_group.this.name
  private_dns_zone_name = var.dns_zone_name
  virtual_network_id    = each.value.vnet.id
  registration_enabled  = each.value.vnet_input.registration_enabled
  depends_on            = [azurerm_private_dns_zone.private_dns_zones]
}
