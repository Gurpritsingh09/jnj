resource "azurerm_resource_group" "iot_resource_group" {
  name     = "NA-DS-DV-IOT-TEST"
  location = "North Europe"
}

module "iot_hub" {
  source                         = "../../../modules/iot/iot_hub/"
  iot_hub_name                   = "DS-DV-IOT-TEST"
  iot_resource_group_name        = azurerm_resource_group.iot_resource_group.name
  iot_hub_storage_account_name   = "IOTSATEST" #must be only alphanumeric without special character
  iot_location                   = azurerm_resource_group.iot_resource_group.location
  iot_hub_storage_container_name = "DS-DV-IOT-Container-TEST"
  iot_hub_endpoint_name          = "events"
  iot_hub_consumer_group_name    = "DS-DV-IOT-ConsumerGroup-TEST"


  # iot_ip_filter_rules = [{
  #   name = "ip filter name",
  #   action = "Accept",
  #   ip_mask_range = "10.0.0.0/31"
  #  }]

  iot_tags = {
    environment = "terraform-test"
    owner       = "Infra team"
    created-by  = "vdubey3"
  }
}
