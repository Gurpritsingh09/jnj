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
    sa1 = lookup(module.StorageAccount.sa_ids_map, var.storage_accounts.sa1.name, null)
  }
  virtual_network_subnet_ids = [for x in data.azurerm_subnet.ds : x.id]
  storage_accounts = var.restrict_public_access == true ? { for key, value in var.storage_accounts : key => {
    name            = value.name
    sku             = value.sku
    account_kind    = value.account_kind
    access_tier     = value.access_tier
    assign_identity = value.assign_identity # set this as true to assign MSI to storage account
    cmk_enable      = value.cmk_enable      #set this as true to enable encryption of storage account using customer managed key
    network_rules = {
      bypass                     = null
      default_action             = "Deny"
      ip_rules                   = null
      virtual_network_subnet_ids = [for x in data.azurerm_subnet.ds : x.id]
    }
    enable_large_file_share = value.enable_large_file_share
  } } : var.storage_accounts
}

# Storage Account

module "StorageAccount" {
  source              = "../../../../../../modules/StorageAccount"
  resource_group_name = var.resource_group_name
  key_vault_id        = data.terraform_remote_state.kv.outputs.key_vault_id
  storage_accounts    = local.storage_accounts
  containers          = var.containers
  blobs               = var.blobs
  queues              = var.queues
  file_shares         = var.file_shares
  tables              = var.tables
  sa_additional_tags  = var.tags
}

# Private endpoint 

module "PrivateEndpoint" {
  source              = "../../../../../../modules/PrivateEndpoint"
  private_endpoints   = var.private_endpoints
  resource_group_name = var.pe_resource_group_name
  subnet_ids          = data.terraform_remote_state.vnet.outputs.map_subnets.subnet2.id
  vnet_ids            = data.terraform_remote_state.vnet.outputs.map_vnets.virtualnetwork1.id
  resource_ids        = local.resource_ids
  tags                = var.tags
}


