
# ApplicationInsights

output "instrumentation_key_map" {
  value = { for x in azurerm_application_insights.this : x.name => x.instrumentation_key }
}

output "app_id_map" {
  value = { for x in azurerm_application_insights.this : x.name => x.app_id }
}

output "resource_group_name" {
  value = { for x in azurerm_application_insights.this : x.name => x.resource_group_name}
}

output "location" {
  value = { for x in azurerm_application_insights.this : x.name => x.location}
}

output "name" {
  value = { for x in azurerm_application_insights.this : x.name => x.name}
}