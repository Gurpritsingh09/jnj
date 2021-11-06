output "log_analytics_workspace_name" {
     value =  values(azurerm_log_analytics_workspace.example)[*].name
    description = "Log Analytics workspace name"
}

output "log_analytics_workspace_sku" {
    value =  values(azurerm_log_analytics_workspace.example)[*].sku
    description = "Log Analytics workspace sku"
}