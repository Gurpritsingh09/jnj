diagnostic_settings_name = "diagnostic-aks"

log_analytics_resource_group = "EUN-DS-QA-LGA-SH"
log_analytics_workspace_name = "DS-QA-LGA"

diagnostic_storageaccount_name           = "eundsqastgsh"
diagnostic_storageaccount_resource_group = "EUN-DS-QA-STG-SH"

target_resource = {
  aks1 = {
    resource_group = "EUN-DS-QA-AKS-VELYS"
    resource_name  = "DS-QA-AKS-VELYS"
  }
}

diagnostic_logs = [
  {
    category = "kube-audit"
    enabled  = true
    retention_policy = {
      enabled = true
      days    = 90
    }
  },
  {
    category = "cluster-autoscaler"
    enabled  = true
    retention_policy = {
      enabled = true
      days    = 90
    }
  },
  {
    category = "kube-apiserver"
    enabled  = true
    retention_policy = {
      enabled = true
      days    = 90
    }
  },
  {
    category = "kube-audit-admin"
    enabled  = true
    retention_policy = {
      enabled = true
      days    = 90
    }
  },
  {
    category = "kube-controller-manager"
    enabled  = true
    retention_policy = {
      enabled = true
      days    = 90
    }
  },
  {
    category = "kube-scheduler"
    enabled  = true
    retention_policy = {
      enabled = true
      days    = 90
    }
  },
  {
    category = "guard"
    enabled  = true
    retention_policy = {
      enabled = true
      days    = 90
    }
  }
]

diagnostic_metrics = [{
  category = "AllMetrics"
  enabled  = true
  retention_policy = {
    enabled = true
    days    = 90
  }
}]
