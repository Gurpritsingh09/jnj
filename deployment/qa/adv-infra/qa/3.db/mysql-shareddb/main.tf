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

data "azurerm_subnet" "aks_subnet" {
  name                 = "AKS"
  virtual_network_name = "DS-QA-VNET"
  resource_group_name  = "EUN-DS-QA-NWK-SH"
}

locals {
  resource_ids = {
    mysql01 = module.QAMySqlDatabase.mysql_server_id
  }
}

# MySQL Database

module "QAMySqlDatabase" {
  source                       = "../../../../../../modules/MySqlDatabase"
  resource_group_name          = var.resource_group_name
  subnet_ids                   = data.azurerm_subnet.aks_subnet.id
  key_vault_id                 = data.terraform_remote_state.kv.outputs.key_vault_id
  server_name                  = var.server_name
  database_names               = var.database_names
  administrator_login_password = var.administrator_login_password
  mysql_admin_azure_ad_user    = var.mysql_admin_azure_ad_user
  administrator_login_name     = var.administrator_login_name
  allowed_subnet_names         = var.allowed_subnet_names
  sku_name                     = var.sku_name
  mysql_version                = var.mysql_version
  storage_mb                   = var.storage_mb
  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  #geo_redundant_backup                = var.geo_redundant_backup
  auto_grow_enabled = var.auto_grow_enabled
  #auto_grow                           = var.auto_grow
  private_endpoint_connection_enabled = var.private_endpoint_connection_enabled
  ssl_minimal_tls_version             = var.ssl_minimal_tls_version
  infrastructure_encryption_enabled   = var.infrastructure_encryption_enabled
  tags                                = var.tags
  firewall_rules                      = var.firewall_rules
  mysql_configurations                = var.mysql_configurations
  diagnostics_storage_account         = var.diagnostics_storage_account
  diagnostics_storage_account_rg      = var.diagnostics_storage_account_rg
}

# Private Endpoint

module "PrivateEndpoint" {
  source              = "../../../../../../modules/PrivateEndpoint"
  private_endpoints   = var.private_endpoints
  resource_group_name = var.pe_resource_group_name
  subnet_ids          = data.terraform_remote_state.vnet.outputs.map_subnets.subnet2.id
  vnet_ids            = data.terraform_remote_state.vnet.outputs.map_vnets.virtualnetwork1.id
  resource_ids        = local.resource_ids
  tags                = var.tags
}

#ADDING MISSING VIRTUAL NETWORK LINK SINCE PRIVATE ENDPOINT DOESNT COVER IT
#resource "azurerm_private_dns_zone_virtual_network_link" "this" {
#  name                  = "ds-qa-prm-vnet-link" #VNET NAME-link
#  resource_group_name   = "EUN-DS-QA-NWK-SH"     #NWK RG
#  private_dns_zone_name = "privatelink.mysql.database.azure.com"
#  virtual_network_id    = data.terraform_remote_state.vnet.outputs.map_vnets.virtualnetwork2.id #PRM-VNET-ID
#  registration_enabled  = false
#  depends_on            = [module.PrivateEndpoint]
#}
