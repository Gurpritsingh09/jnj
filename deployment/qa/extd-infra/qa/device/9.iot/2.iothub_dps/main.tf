data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

module "iothub_dps" {
  source              = "../../../../../../../modules/iot/iothub_dps/"
  name                = var.iot_dps_name
  iot_hub_name        = var.iot_hub_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  iot_tags            = var.iot_tags
  iothub_dps_sku      = var.iothub_dps_sku
}
