output "adusers" {
  value = [for user in module.azuread_users.azuread_users : user.user_principal_name]
}
