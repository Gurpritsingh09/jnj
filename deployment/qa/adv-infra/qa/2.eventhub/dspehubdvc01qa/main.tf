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

data "azurerm_virtual_network" "ds" {
  name                = var.eventhub_vn_name
  resource_group_name = var.pe_resource_group_name
}

data "azurerm_subnet" "ds" {
  for_each             = toset(data.azurerm_virtual_network.ds.subnets)
  name                 = each.value
  virtual_network_name = var.eventhub_vn_name
  resource_group_name  = var.pe_resource_group_name
}

locals {
  resource_ids = {
    eventhub = module.EventHub.namespace_id
  }
  network_rules = { ip_rules = [], subnet_ids = [for x in data.azurerm_subnet.ds : x.id] }
}

## EventHub

module "EventHub" {
  source              = "../../../../../../modules/EventHub"
  resource_group_name = var.resource_group_name
  name                = var.eventhub_name
  hubs                = var.hubs
  tags                = var.tags
  network_rules       = var.restrict_public_access == true ? local.network_rules : null
  capacity            = var.capacity
  auto_inflate        = var.auto_inflate
}

## Private Endpoint

module "PrivateEndpoint" {
  source              = "../../../../../../modules/PrivateEndpoint"
  private_endpoints   = var.private_endpoints
  resource_group_name = var.pe_resource_group_name
  subnet_ids          = data.terraform_remote_state.vnet.outputs.map_subnets.subnet2.id
  vnet_ids            = data.terraform_remote_state.vnet.outputs.map_vnets.virtualnetwork1.id
  resource_ids        = local.resource_ids
  tags                = var.tags
}
