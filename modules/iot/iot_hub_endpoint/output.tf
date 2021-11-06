output "iot_hub_messaging_endpoint" {
  value = azurerm_iothub_endpoint_eventhub.endpoint.name
}

output "iot_hub_messaging_route" {
  value = azurerm_iothub_route.route.name
}

output "iot_hub_messaging_routing_query" {
  value = azurerm_iothub_route.route.condition
}
