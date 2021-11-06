output "iothub_dps" {
  value = azurerm_iothub_dps.iot_hub_dps
}

output "iothub_dps_location" {
  value = azurerm_iothub_dps.iot_hub_dps.location
}

output "iothub_dps_resource_group" {
  value = azurerm_iothub_dps.iot_hub_dps.resource_group_name
}

# output "iothub_dps_linked_iot_hub" {
#   value = azurerm_iothub_dps.iot_hub_dps.resource_group_name
# }

output "iothub_dps_pricing" {
  value = azurerm_iothub_dps.iot_hub_dps.sku[0].name
}
