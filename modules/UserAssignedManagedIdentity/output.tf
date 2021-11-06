output "name" {
  value = azurerm_user_assigned_identity.function-id.name
}

output "id" {
  value = azurerm_user_assigned_identity.function-id.id
}

output "principal_id" {
  value = azurerm_user_assigned_identity.function-id.principal_id
}

output "client_id" {
  value = azurerm_user_assigned_identity.function-id.client_id
}
