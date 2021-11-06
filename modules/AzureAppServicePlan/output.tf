output "app-service-plan-id" {
  value       = azurerm_app_service_plan.app_service_plan.id
  description = "Deployed App Service Plan ID"
}
