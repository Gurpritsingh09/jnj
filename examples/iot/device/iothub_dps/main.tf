
module "iothub_dps" {
  source              = "../../../../../../../modules/iot/iothub_dps/"
  name                = var.iot_dps_name
  iot_hub_name        = var.iot_hub_name
  resource_group_name = var.resource_group_name
  location            = var.location
  iot_tags            = var.iot_tags
  iothub_dps_sku      = var.iothub_dps_sku
}
