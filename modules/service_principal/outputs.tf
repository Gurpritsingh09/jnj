output "spns" {
  value = [for spn in azuread_application.app : spn.name]
}

output "service_principal_password" {
  value = azuread_service_principal_password.sp_password
}

output "azuread_service_principal" {
  value = azuread_service_principal.sp
}

output "azuread_application" {
  value = azuread_application.app
}