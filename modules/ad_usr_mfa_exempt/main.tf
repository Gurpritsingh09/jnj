# Generate passwords for each AD user
resource "random_password" "password" {
  count            = length(var.adusers)
  length           = 32
  special          = true
  min_upper        = 5
  min_numeric      = 3
  override_special = "!#_-"
  min_special      = 4
}

locals {
  azure_adusers = [for count, aduser in var.adusers :
    merge(aduser, { password = random_password.password[count].result })
  ]
}
resource "azuread_user" "aduser" {
  count               = length(local.azure_adusers)
  user_principal_name = local.azure_adusers[count.index].user_principal_name
  display_name        = local.azure_adusers[count.index].display_name
  password            = local.azure_adusers[count.index].password
}

# Add the created.adusers to MFA Exempt AD User
resource "azuread_group_member" "mfa" {
  count            = length(local.azure_adusers)
  group_object_id  = data.azuread_group.mfa_exempt.id
  member_object_id = azuread_user.aduser[count.index].id
  depends_on       = [azuread_user.aduser]
}

resource "azurerm_key_vault_secret" "this" {
  count        = length(local.azure_adusers)
  name         = replace(local.azure_adusers[count.index].user_principal_name, "/@.*/", "")
  value        = local.azure_adusers[count.index].password
  key_vault_id = data.azurerm_key_vault.vault.id
  depends_on   = [azuread_group_member.mfa]
}


