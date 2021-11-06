# The module supports only log analytics workspace as logs sink / destination

# locals {
#   # local count variable that determines if diagnostics are deployed or not
#   diag_count = var.enable ? 1 : 0
# }

resource "azurerm_monitor_diagnostic_setting" "diag_setting" {
  name               = var.diagnostic_settings_name
  target_resource_id = var.target_resource_id
  #count = local.diag_count

  #  log analytics workspace destination

  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  storage_account_id         = var.skip_archive == "true" ? null : data.azurerm_storage_account.storage_account.id

  # Specify the log categories -  to be stored
  dynamic "log" {
    for_each = var.diagnostic_logs
    content {
      category = log.value.category
      enabled  = log.value.enabled
      retention_policy {
        enabled = log.value.retention_policy.enabled
        days    = log.value.retention_policy.days
      }
    }
  }

  # Specify the metrics to be stored 
  dynamic "metric" {
    for_each = var.diagnostic_metrics
    content {
      category = metric.value.category
      enabled  = metric.value.enabled
      retention_policy {
        enabled = metric.value.retention_policy.enabled
        days    = metric.value.retention_policy.days
      }
    }
  }

  # Check if there are any dependencies required
  #depends_on = [
  #  var.ds_depends_on
  #]
}
