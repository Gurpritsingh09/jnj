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
  min_tls_version           = "TLS1_2"
  network_rules {
    bypass                     = var.network_bypass
    ip_rules                   = var.ip_rules
    virtual_network_subnet_ids = var.virtual_network_subnet_ids
    default_action             = var.default_action
  }
  tags = var.tags
}
