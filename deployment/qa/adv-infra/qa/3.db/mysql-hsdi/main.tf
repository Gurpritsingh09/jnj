data "azurerm_key_vault" "kv" {
  name                = "EUN-DS-QA-VLT"
  resource_group_name = "EUN-DS-QA-KEY-SH"
}

data "azurerm_subnet" "tenant_subnet" {
  name                 = "HSDI"
  virtual_network_name = "DS-QA-VNET"
  resource_group_name  = "EUN-DS-QA-NWK-SH"
}

data "azurerm_subnet" "pvt_subnet" {
  name                 = "PVT"
  virtual_network_name = "DS-QA-VNET"
  resource_group_name  = "EUN-DS-QA-NWK-SH"
}

data "azurerm_virtual_network" "vnet" {
  name                = "DS-QA-VNET"
  resource_group_name = "EUN-DS-QA-NWK-SH"
}
//KEYVAULT ID,SUBNET ID, VNET ID
locals {
  resource_ids = {
    mysql03 = module.HSDIQAMySqlDatabase.mysql_server_id
  }

}

# MySQL Database for DVC

module "HSDIQAMySqlDatabase" {
  source                              = "../../../../../../modules/MySqlDatabase"
  resource_group_name                 = var.resource_group_name
  subnet_ids                          = data.azurerm_subnet.tenant_subnet.id
  key_vault_id                        = data.azurerm_key_vault.kv.id
  server_name                         = var.hsdi_server_name
  database_names                      = var.hsdi_database_names
  administrator_login_password        = var.hsdi_administrator_login_password
  mysql_admin_azure_ad_user           = var.hsdi_mysql_admin_azure_ad_user
  administrator_login_name            = var.hsdi_administrator_login_name
  allowed_subnet_names                = var.hsdi_allowed_subnet_names
  sku_name                            = var.hsdi_sku_name
  mysql_version                       = var.hsdi_mysql_version
  storage_mb                          = var.hsdi_storage_mb
  backup_retention_days               = var.hsdi_backup_retention_days
  geo_redundant_backup_enabled        = var.hsdi_geo_redundant_backup_enabled
  auto_grow_enabled                   = var.hsdi_auto_grow_enabled
  private_endpoint_connection_enabled = var.hsdi_private_endpoint_connection_enabled
  ssl_minimal_tls_version             = var.hsdi_ssl_minimal_tls_version
  infrastructure_encryption_enabled   = var.hsdi_infrastructure_encryption_enabled
  tags                                = var.tags
  firewall_rules                      = var.hsdi_firewall_rules
  mysql_configurations                = var.hsdi_mysql_configurations
  diagnostics_storage_account         = var.diagnostics_storage_account
  diagnostics_storage_account_rg      = var.diagnostics_storage_account_rg
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
  depends_on          = [module.HSDIQAMySqlDatabase]
}
