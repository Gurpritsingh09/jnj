# #############################################################################
# # OUTPUTS Application Gateway
# #############################################################################

output "application_gateway_ids" {
  value = [for x in azurerm_application_gateway.this : x.id]
}

output "application_gateway_ids_map" {
  value = { for x in azurerm_application_gateway.this : x.name => x.id }
}

output "application_gateway_name" {
  description = "Name of the Application Gateway"
  value       = [ for a in azurerm_application_gateway.this : a.name ]
}

output "application_gateway_location" {
  description = "Location of the Application Gateway"
  value       = [ for a in azurerm_application_gateway.this : a.location ]
}
