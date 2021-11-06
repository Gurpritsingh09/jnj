module "azuread_users" {
  source        = "../../../../../modules/ad_usr_mfa_exempt"
  adusers       = var.adusers
  keyvault_name = var.keyvault_name
  keyvault_rg   = var.keyvault_rg
  mfa_ad_group  = var.mfa_ad_group
}
