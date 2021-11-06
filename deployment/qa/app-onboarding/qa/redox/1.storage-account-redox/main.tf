data "azurerm_key_vault" "kv" {
  name                = var.keyvault_name
  resource_group_name = var.keyvault_resource_group
}

data "azurerm_subnet" "pvt_subnet" {
  name                 = "PVT"
  virtual_network_name = var.sa_vn_name
  resource_group_name  = var.pe_resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.sa_vn_name
  resource_group_name = var.pe_resource_group_name
}

data "azurerm_subnet" "dsnpd" {
  for_each             = toset(local.spec_subnets)
  name                 = each.value
  virtual_network_name = var.sa_vn_name
  resource_group_name  = var.pe_resource_group_name
}

locals {
  spec_subnets = length(var.specific_subnets) > 0 ? var.specific_subnets : data.azurerm_virtual_network.vnet.subnets

  resource_ids = {
    sa1 = lookup(module.StorageAccount.sa_ids_map, var.storage_accounts.sa1.name, null)
  }

  virtual_network_subnet_ids = [for x in data.azurerm_subnet.dsnpd : x.id]

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
      ip_rules                   = ["52.205.60.156", "52.205.89.86", "52.205.169.24"]
      virtual_network_subnet_ids = [for x in data.azurerm_subnet.dsnpd : x.id]
    }
    enable_large_file_share = value.enable_large_file_share
  } } : var.storage_accounts
}

# Storage Account
module "StorageAccount" {
  source              = "../../../../../../modules/StorageAccount"
  resource_group_name = var.resource_group_name
  key_vault_id        = data.azurerm_key_vault.kv.id
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
  subnet_ids          = data.azurerm_subnet.pvt_subnet.id
  vnet_ids            = data.azurerm_virtual_network.vnet.id
  resource_ids        = local.resource_ids
  tags                = var.tags
}
