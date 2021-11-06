
module "iothub_dps" {
  source                  = "../../../modules/iot/iothub_dps/"
  iot_hub_name            = "DS-DV-IOT-TST"
  iot_resource_group_name = "NA-DS-DV-IOT-TST"
  iot_location            = "North Europe"

  iot_tags = {
    environment = "terraform-test"
    owner       = "Infra team"
    created-by  = "vdubey3"
  }

}
