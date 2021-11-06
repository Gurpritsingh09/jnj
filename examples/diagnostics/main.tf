
module  "iothub_diagnostic_setting" {
  source             = "../../modules/diagnostics/" 
  diagnostic_settings_name               = "DS-DV-IOT-TST-Diagnostics"
  enable = true
  target_resource_id = "/subscriptions/3e6dbe4e-54bc-4571-b879-08a5011f22f1/resourceGroups/NA-DS-DV-IOT-TST/providers/Microsoft.Devices/IotHubs/DS-DV-IOT-TST"
  
  log_analytics_resource_group = "na-ds-npd-lga-sh" 
  log_analytics_workspace_name = "DS-NPD-LGA"

  diagnostic_logs = [{
    category = "Connections"
    enabled  = true

    retention_policy= {
      enabled = true
      days    = 90
    }
  },
  {
    category = "DeviceTelemetry"
    enabled  = true

    retention_policy= {
      enabled = true
      days    = 90
    }
  }]
  diagnostic_metrics=[{
    category = "AllMetrics"
    enabled  = true

    retention_policy= {
      enabled = true
      days    = 90
    }
  }]
}
