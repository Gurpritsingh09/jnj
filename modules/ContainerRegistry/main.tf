# Container Registry

locals {
  tags = merge(var.tags, data.azurerm_resource_group.this.tags)
}

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

resource "azurerm_container_registry" "this" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.this.name
  location            = var.location
  sku                 = var.sku
  tags                = local.tags
  
  trust_policy {
    enabled = var.trust_policy
  }
}

# Diagnostics Settings

data "azurerm_storage_account" "this" {
  name                = var.diagnostics_storage_account
  resource_group_name = var.diagnostics_storage_account_rg
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name               = "diagnostics"
  target_resource_id = azurerm_container_registry.this.id
  storage_account_id = data.azurerm_storage_account.this.id

  log {
    category = "ContainerRegistryLoginEvents"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 90
    }
  }
  log {
    category = "ContainerRegistryRepositoryEvents"
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
