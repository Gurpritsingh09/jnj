output "ad_groups" {
  description = "Display created Azure AD Groups"
  value       = module.azureadgroup.output_ad_groups_id
}
