data "azurerm_resource_group" "rg" {
  name = var.iot_resource_group_name
}

module "iot_hub" {
  source                  = "../../../../../../../modules/iot/iot_hub/"
  iot_hub_name            = var.iot_hub_name
  iot_location            = data.azurerm_resource_group.rg.location
  iot_resource_group_name = data.azurerm_resource_group.rg.name
  # iot_location            = var.iot_location
  # iot_resource_group_name = var.iot_resource_group_name

  iot_hub_sku = var.iot_hub_sku

  iot_hub_storage_resource_group_name = var.iot_hub_storage_resource_group_name
  iot_hub_storage_account_name        = var.iot_hub_storage_account_name
  iot_hub_storage_container_name      = var.iot_hub_storage_container_name

  iot_tags = var.iot_tags
}

module "iot-hub-endpoint" {
  source = "../../../../../../../modules/iot/iot_hub_endpoint/"

  iot_hub_name            = module.iot_hub.iot_hub_name
  iot_resource_group_name = module.iot_hub.iot_hub_resource_group_name

  for_each = var.endpoints

  iot_hub_endpoint_name        = each.value.endpoint-name
  eventhub-resource-group-name = each.value.eventhub-resource-group-name
  eventhub-namespace-name      = each.value.eventhub-namespace-name
  eventhub-eventhub-name       = each.value.eventhub-eventhub-name
  eventhub-auth-rule-name      = each.value.eventhub-auth-rule-name
  iothub-route-name            = each.value.endpoint-route-name
  iothub-route-source          = each.value.endpoint-route-source
  iothub-route-condition       = each.value.endpoint-route-condition
  iothub-route-enabled         = each.value.endpoint-route-enabled

  depends_on = [module.iot_hub]
}
