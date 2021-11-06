data "azurerm_storage_account" "iothub_storage_account" {
  name                = lower(var.iot_hub_storage_account_name)
  resource_group_name = var.iot_hub_storage_resource_group_name
}
