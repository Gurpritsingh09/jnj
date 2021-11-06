data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "EUN-DS-QA-STG-TF"
    storage_account_name = "eunqaterraformsta"
    container_name       = "qa-deployment"
    key                  = "networking.tfstate"
  }
}

data "terraform_remote_state" "kv" {
  backend = "azurerm"
  config = {
    resource_group_name  = "EUN-DS-QA-STG-TF"
    storage_account_name = "eunqaterraformsta"
    container_name       = "qa-deployment"
    key                  = "keyvaults.tfstate"
  }
}

data "azurerm_subnet" "agy_subnet" {
  name                 = "AGY"
  virtual_network_name = "DS-QA-VNET"
  resource_group_name  = "EUN-DS-QA-NWK-SH"
}
# Application Gateway 

module "ApplicationGateway" {
  source               = "../../../../../modules/ApplicationGateway"
  resource_group_name  = var.resource_group_name
  subnet_ids           = data.azurerm_subnet.agy_subnet.id
  application_gateways = var.application_gateways
  waf_policies         = var.waf_policies
  agw_private_ip       = var.agw_private_ip
}
