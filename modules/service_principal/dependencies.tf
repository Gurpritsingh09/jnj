data "azurerm_key_vault" "vault" {
  name                = var.keyvault_name
  resource_group_name = var.keyvault_rg
}

data "azuread_group" "mfa_exempt" {
  name = var.mfa_ad_group
}
