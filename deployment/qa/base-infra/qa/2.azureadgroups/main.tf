
module "mod_dsp_azureadgroup" {
  source = "../../../../../modules/azureadgroup/" 
  azuread_security_groups = var.dsp_azuread_security_groups
}
