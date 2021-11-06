locals{
 #dsp_ad_groups = ["DS-MG-Owner", "DS-MG-Contributor", "DS-MG-Reader"]
 dsp_ad_groups = ["DS-MG-Contributor"]
 dsp_rgs       = ["NA-DS-NPD-LGA-SH"]
 role_definition_name = "Contributor"
}

module "ad_role_assignment_at_subscription_scope" {
  source = "../../modules/azure_role_assignment/"
  
  ad_groups = local.dsp_ad_groups
  rgs       = local.dsp_rgs
  role_definition_name = local.role_definition_name
  applicable_at_subscription_scope = true
  applicable_at_resource_grp_scope = false
}

module "ad_role_assignment_mgmt_group_scope" {
  source = "../../modules/azure_role_assignment/"
  
  ad_groups = local.dsp_ad_groups
  rgs       = local.dsp_rgs
  role_definition_name = local.role_definition_name
  applicable_at_mgmt_grp_scope = false
}

module "ad_role_assignment_rg_scope" {
  source = "../../modules/azure_role_assignment/"

  ad_groups = local.dsp_ad_groups
  rgs       = local.dsp_rgs
  role_definition_name = local.role_definition_name
  applicable_at_resource_grp_scope = true
}
