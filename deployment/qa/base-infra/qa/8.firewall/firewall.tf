module "firewall" {
  source                  = "../../../../../modules/firewall/"
  azure_fw_name           = "DS-QA-PRM-FW"
  azure_fw_resource_group = "EUN-DS-QA-NWK-SH"
  azure_fw_location       = "northeurope"
  vnet_name               = "DS-QA-PRM-VNET"
  fw_subnet_address_space = ["172.27.0.0/24"]
  tags = {
    environment = "qa"
    owner       = "Infra Team"
    created-by  = "Terraform provisioned"
  }
}
