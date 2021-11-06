locals {
  tags                         = merge(var.tags, data.azurerm_resource_group.this.tags)
  administrator_login_password = var.administrator_login_password == null ? random_string.this.result : var.administrator_login_password
}

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}
data "azurerm_client_config" "current" {}

data "azuread_user" "this" {
  user_principal_name = var.mysql_admin_azure_ad_user
}
# Add MY SQL Server Admin Login Password to Key Vault secrets

resource "null_resource" "dependency_kv" {
  provisioner "local-exec" {
    command = "echo ${length(var.dependencies)}"
  }
}

resource "random_string" "this" {
  length      = 32
  special     = true
  min_upper   = 5
  min_numeric = 3
  #override_special = "/@"
  min_special = 4
}

resource "azurerm_key_vault_secret" "this" {
  name         = azurerm_mysql_server.this.name
  value        = local.administrator_login_password
  key_vault_id = var.key_vault_id
  depends_on   = [azurerm_mysql_server.this, null_resource.dependency_kv]
}

# MY SQL Server

resource "azurerm_mysql_server" "this" {
  name                         = var.server_name
  location                     = data.azurerm_resource_group.this.location
  resource_group_name          = data.azurerm_resource_group.this.name
  sku_name                     = var.sku_name
  version                      = var.mysql_version
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  storage_mb                   = var.storage_mb
  backup_retention_days        = var.backup_retention_days
  auto_grow_enabled            = var.auto_grow_enabled
  administrator_login          = var.administrator_login_name
  administrator_login_password = local.administrator_login_password
  ssl_enforcement_enabled      = true
  # ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = var.ssl_minimal_tls_version
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  # - MY SQL Allow/Deny Public Network Access
  # - Only private endpoint connections will be allowed to access this resource if "private_endpoint_connection_enabled" variable is set to true
  public_network_access_enabled = var.private_endpoint_connection_enabled ? false : true
  tags                          = local.tags
  lifecycle {
    ignore_changes = [administrator_login_password]
  }
}

# MY SQL Databases

resource "azurerm_mysql_database" "this" {
  count               = length(var.database_names)
  name                = element(var.database_names, count.index)
  resource_group_name = data.azurerm_resource_group.this.name
  server_name         = azurerm_mysql_server.this.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
  depends_on          = [azurerm_mysql_server.this]
}

# MY SQL Configuration/Server Parameters

resource "azurerm_mysql_configuration" "this" {
  for_each            = var.mysql_configurations
  name                = each.key
  resource_group_name = data.azurerm_resource_group.this.name
  server_name         = azurerm_mysql_server.this.name
  value               = each.value
  depends_on          = [azurerm_mysql_server.this]
}

resource "azurerm_mysql_active_directory_administrator" "this" {
  server_name         = azurerm_mysql_server.this.name
  resource_group_name = data.azurerm_resource_group.this.name
  login               = var.mysql_admin_azure_ad_user
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azuread_user.this.id
}
# MY SQL Virtual Network Rule. Enabled only if "private_endpoint_connection_enabled" variable is set to false

resource "azurerm_mysql_virtual_network_rule" "this" {
  count               = var.private_endpoint_connection_enabled == false ? length(var.allowed_subnet_names) : 0
  name                = "mysql-vnet-rule-${count.index + 1}"
  resource_group_name = data.azurerm_resource_group.this.name
  server_name         = azurerm_mysql_server.this.name
  subnet_id           = var.subnet_ids
  depends_on          = [azurerm_mysql_server.this]
}

# MY SQL Firewall Rule. Enabled only if "private_endpoint_connection_enabled" variable is set to false

resource "azurerm_mysql_firewall_rule" "this" {
  for_each            = var.private_endpoint_connection_enabled == false ? var.firewall_rules : {}
  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.this.name
  server_name         = azurerm_mysql_server.this.name
  start_ip_address    = each.value.start_ip_address
  end_ip_address      = each.value.end_ip_address
  depends_on          = [azurerm_mysql_server.this]
}

# Enable Diagnostic storage account data for configuring the audit logss

data "azurerm_storage_account" "this" {
  name                = var.diagnostics_storage_account
  resource_group_name = var.diagnostics_storage_account_rg
}

resource "azurerm_monitor_diagnostic_setting" "diag" {
  name               = var.server_name
  target_resource_id = azurerm_mysql_server.this.id
  storage_account_id = data.azurerm_storage_account.this.id

  log {
    category = "MySqlSlowLogs"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 90
    }
  }
  log {
    category = "MySqlAuditLogs"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 90
    }
  }
  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 90
    }
  }
}
