iot_hub_name = "DS-QA-IOT-DVC"
iot_dps_name = "DS-QA-IOT-DPS-DVC"

resource_group_name = "NA-DS-QA-DVC-SVC"
location            = "North Europe"

iothub_dps_sku = {
  iot_sku = {
    name     = "S1"
    capacity = 1
  }
}

iot_tags = {
  environment  = "QA"
  owner        = "Infra Team"
  created-by   = "Terraform Provisioned"
  team         = "Device"
  application  = "Device"
  dsep_version = "2.0"
}
