output "iot_hub" {
  value = azurerm_iothub.hub
}

output "iot_hub_name" {
  value = azurerm_iothub.hub.name
}

output "iot_hub_resource_group_name" {
  value = azurerm_iothub.hub.resource_group_name
}

output "iot_hub_location" {
  value = azurerm_iothub.hub.location
}

output "iot_hub_pricing" {
  value = azurerm_iothub.hub.sku[0].name
}

output "iot_hub_scale" {
  value = azurerm_iothub.hub.sku[0].capacity
}
