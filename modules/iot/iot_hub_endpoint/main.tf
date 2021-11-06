resource "azurerm_iothub_endpoint_eventhub" "endpoint" {
  name                = var.iot_hub_endpoint_name
  iothub_name         = var.iot_hub_name
  resource_group_name = var.iot_resource_group_name
  connection_string   = data.azurerm_eventhub_authorization_rule.evhub-auth-rule.primary_connection_string
}

resource "azurerm_iothub_route" "route" {
  resource_group_name = var.iot_resource_group_name
  iothub_name         = var.iot_hub_name

  name           = var.iothub-route-name
  source         = var.iothub-route-source
  condition      = var.iothub-route-condition
  enabled        = var.iothub-route-enabled
  endpoint_names = [azurerm_iothub_endpoint_eventhub.endpoint.name]

  depends_on = [azurerm_iothub_endpoint_eventhub.endpoint]
}
