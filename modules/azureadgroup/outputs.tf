

output "output_ad_groups_id" {
  # value       = values(azuread_group.dsp_ad_groups)[*].id
  value       = values(azuread_group.dsp_ad_groups)[*]
  description = "Output AD Groups' id"
}

output "tf_test_ad_groups_name" {
  value       = values(azuread_group.dsp_ad_groups)[*].name
  description = "Output AD Groups' name"
}
