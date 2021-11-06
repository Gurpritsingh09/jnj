diagnostic_settings_name = "diagnostic-storage-account"

log_analytics_resource_group = "EUN-DS-QA-LGA-SH"
log_analytics_workspace_name = "DS-QA-LGA"

diagnostic_storageaccount_name           = "eundsqastgsh"
diagnostic_storageaccount_resource_group = "EUN-DS-QA-STG-SH"

target_resource = [
  {
    resource_group = "EUN-DS-QA-STG-DVC"
    resource_name  = "eundsqastgdvc"
    skip_archive   = "false"
  }
]

diagnostic_logs = []

diagnostic_logs_bfqt = [
  {
    category = "StorageRead"
    enabled  = true
    retention_policy = {
      enabled = false
      days    = 90
    }
  },
  {
    category = "StorageWrite"
    enabled  = true
    retention_policy = {
      enabled = false
      days    = 90
    }
  },
  {
    category = "StorageDelete"
    enabled  = true
    retention_policy = {
      enabled = false
      days    = 90
    }
  }
]

diagnostic_metrics = [{
  category = "Transaction"
  enabled  = true
  retention_policy = {
    enabled = true
    days    = 90
  }
}]
