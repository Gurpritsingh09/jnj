iot_hub_name = "eun-ds-qa-iot-dvc"
iot_dps_name = "eun-ds-qa-iot-dps-dvc"

resource_group_name = "EUN-DS-QA-SVC-DVC"
location            = "North Europe"

iothub_dps_sku = {
  iot_sku = {
    name     = "S1"
    capacity = 1
  }
}

iot_tags = {
  environment  = "QA"
  region       = "eun"
  owner        = "Infra Team"
  created-by   = "Terraform Provisioned"
  team         = "Device"
  application  = "Device"
  dsep_version = "2.0"
  subscription = "Digital Surgery Platform QA EUN"
}
