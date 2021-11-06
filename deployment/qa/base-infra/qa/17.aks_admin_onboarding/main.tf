module "aks_admin_spn_onboarding" {
  source           = "../../../../../modules/adgroup_onboarding"
  adgroups         = var.aks_admin_spn_adgroups
  member_object_id = data.azuread_service_principal.aks_admin_spn.id
}
