output "function_app_name" {
  value       = azurerm_function_app.function_app.name
  description = "Deployed function app name"
}

output "function_app_default_hostname" {
  value       = azurerm_function_app.function_app.default_hostname
  description = "Deployed function app hostname"
}

output "function_app_rg" {
  value       = azurerm_function_app.function_app.resource_group_name
  description = "Deployed function app name"
}
