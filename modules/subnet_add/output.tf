# #############################################################################
# # OUTPUTS VNets, Subnets and NSGs
# #############################################################################


# VNets
output "vnets" {
  value = data.azurerm_virtual_network.vnet
}

output "rt" {
  value = data.azurerm_route_table.rt
}

