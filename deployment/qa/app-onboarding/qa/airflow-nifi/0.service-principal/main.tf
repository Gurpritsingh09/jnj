module "service_principals" {
  source        = "../../../../../../modules/service_principal"
  spns          = var.tenant_app_spn
  mfa_ad_group  = var.mfa_ad_group
  keyvault_name = var.kv_name
  keyvault_rg   = var.kv_rg
} 
