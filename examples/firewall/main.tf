

module "firewall" {
  source                  = "../../modules/firewall/"
  azure_fw_name           = "aks-terraform-fw"
  azure_fw_resource_group = "aks-terraform"
  azure_fw_location       = "northeurope"
  vnet_name               = "aksvnet"
  fw_subnet_address_space = ["16.20.0.0/24"]
  tags = {
    environment = "terraform-test"
    owner       = "Infra team"
    created-by  = "vdubey3"
  }
}
