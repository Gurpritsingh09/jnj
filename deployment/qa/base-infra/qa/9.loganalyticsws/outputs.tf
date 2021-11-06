output "tf_test_log_analytics_workspace_name" {
    value =  module.mod_loganalyticsworkspace.log_analytics_workspace_name
    description = "Log Analytics workspace name"
}

output "tf_test_log_analytics_workspace_sku" {
    value =  module.mod_loganalyticsworkspace.log_analytics_workspace_sku
    description = "Log Analytics workspace sku"
}