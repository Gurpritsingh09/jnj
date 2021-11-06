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
  name                = var.sa_vn_name
  resource_group_name = var.pe_resource_group_name
}

data "azurerm_subnet" "ds" {
  for_each             = toset(data.azurerm_virtual_network.ds.subnets)
  name                 = each.value
  virtual_network_name = var.sa_vn_name
  resource_group_name  = var.pe_resource_group_name
}

locals {
  resource_ids = {
    sa1 = azurerm_storage_account.sa.id
  }
  network_rules = var.restrict_public_access == true ? {
    bypass                     = null
    ip_rules                   = null
    default_action             = "Deny"
    virtual_network_subnet_ids = [for x in data.azurerm_subnet.ds : x.id]
    } : {
    bypass                     = var.network_bypass
    ip_rules                   = var.ip_rules
    default_action             = var.default_action
    virtual_network_subnet_ids = var.virtual_network_subnet_ids
  }
}


## Storage Account 

resource "azurerm_storage_account" "sa" {
  name                      = var.name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = var.account_tier
  account_kind              = var.account_kind
  access_tier               = var.access_tier
  enable_https_traffic_only = var.enable_https_traffic_only
  is_hns_enabled            = var.is_hns_enabled
  account_replication_type  = var.account_replication_type
  network_rules {
    bypass                     = local.network_rules.bypass
    ip_rules                   = local.network_rules.ip_rules
    default_action             = local.network_rules.default_action
    virtual_network_subnet_ids = local.network_rules.virtual_network_subnet_ids
  }
  tags = var.tags
}


# Private endpoint 

module "PrivateEndpoint" {
  source              = "../../../../../modules/PrivateEndpoint"
  private_endpoints   = var.private_endpoints
  resource_group_name = var.pe_resource_group_name
  subnet_ids          = data.terraform_remote_state.vnet.outputs.map_subnets.subnet2.id
  vnet_ids            = data.terraform_remote_state.vnet.outputs.map_vnets.virtualnetwork1.id
  resource_ids        = local.resource_ids
  tags                = var.tags
}

