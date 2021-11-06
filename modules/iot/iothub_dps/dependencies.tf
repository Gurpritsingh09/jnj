# pull iothub details

#data  "azurerm_iothub" "iot_hub" {
#  name                = var.iot_hub_name
#  resource_group_name = var.iot_resource_group_name
#}

# Pull default IoT Hub Access Policy iothubowner
data "azurerm_iothub_shared_access_policy" "iothub_iothubowner" {
  name                = "iothubowner"
  resource_group_name = var.resource_group_name
  iothub_name         = var.iot_hub_name
}
