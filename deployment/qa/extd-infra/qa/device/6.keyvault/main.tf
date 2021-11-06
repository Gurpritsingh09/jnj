data "azurerm_subnet" "pvt_subnet" {
  name                 = "PVT"
  virtual_network_name = var.vn_name
  resource_group_name  = var.pe_resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vn_name
  resource_group_name = var.pe_resource_group_name
}

data "azurerm_subnet" "subnet" {
  for_each             = toset(data.azurerm_virtual_network.vnet.subnets)
  name                 = each.value
  virtual_network_name = var.vn_name
  resource_group_name  = var.pe_resource_group_name
}

locals {
  resource_ids = {
    keyvault = module.Keyvault.key_vault_id
  }
  network_acls = { bypass = "AzureServices", default_action = "Deny", ip_rules = ["0.0.0.0/0"], virtual_network_subnet_ids = [for x in data.azurerm_subnet.subnet : x.id] }
}

# Key Vault

module "Keyvault" {
  source                          = "../../../../../../modules/KeyVault"
  resource_group_name             = var.resource_group_name
  name                            = var.keyvault_name
  soft_delete_enabled             = var.soft_delete_enabled
  purge_protection_enabled        = var.purge_protection_enabled
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  sku_name                        = var.sku_name
  access_policies                 = var.access_policies
  network_acls                    = var.restrict_public_access == true ? local.network_acls : null
  diagnostics_storage_account     = var.diagnostics_storage_account
  diagnostics_storage_account_rg  = var.diagnostics_storage_account_rg
  tags                            = var.tags
}

# Private Endpoint

module "PrivateEndpoint" {
  source              = "../../../../../../modules/PrivateEndpoint"
  private_endpoints   = var.private_endpoints
  resource_group_name = var.pe_resource_group_name
  subnet_ids          = data.azurerm_subnet.pvt_subnet.id
  vnet_ids            = data.azurerm_virtual_network.vnet.id
  resource_ids        = local.resource_ids
  tags                = var.tags
}
