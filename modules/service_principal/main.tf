# Generate passwords for each SP
resource "random_password" "password" {
  count            = length(var.spns)
  length           = 16
  special          = true
  override_special = "_%@"
}
# Crate the application for SP
resource "azuread_application" "app" {
  for_each = toset(var.spns)
  name     = each.value
}


# Create the SP for each app
resource "azuread_service_principal" "sp" {
  count          = length(var.spns)
  application_id = element([for app in azuread_application.app : app.application_id], count.index)
  depends_on     = [azuread_application.app]
}

# Assign the generated password to the SP
resource "azuread_service_principal_password" "sp_password" {
  count                = length(var.spns)
  service_principal_id = element([for spn in azuread_service_principal.sp : spn.id], count.index)
  value                = element([for pass in random_password.password : pass.result], count.index)
  end_date             = "2099-01-01T01:02:03Z"
  depends_on           = [azuread_service_principal.sp]
}
# Add the created spns to MFA Exempt AD Group
resource "azuread_group_member" "example" {
  count            = length(var.spns)
  group_object_id  = data.azuread_group.mfa_exempt.id
  member_object_id = element([for spn in azuread_service_principal.sp : spn.id], count.index)
  depends_on       = [azuread_service_principal_password.sp_password]
}
locals {
  service_principal_map = { for value in azuread_service_principal.sp : value.id => {
    display_name = value.display_name
  } }
}
resource "azurerm_key_vault_secret" "this" {
  count        = length(var.spns)
  name         = lookup(lookup(local.service_principal_map, (element([for pass in azuread_service_principal_password.sp_password : pass.service_principal_id], count.index)), var.spns[count.index]), "display_name", null)
  value        = element([for pass in azuread_service_principal_password.sp_password : pass.value], count.index)
  key_vault_id = data.azurerm_key_vault.vault.id
  depends_on   = [azuread_service_principal_password.sp_password]
}


