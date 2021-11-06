output "ad_groups" {
  description = "Display created Azure AD Groups"
  value       = module.mod_dsp_azureadgroup.output_ad_groups_id
}

output "tf_test_ad_groups_names" {
  description = "Display created Azure AD Groups names"
  value       = module.mod_dsp_azureadgroup.tf_test_ad_groups_name
}
