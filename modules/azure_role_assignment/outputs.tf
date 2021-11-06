output "supplied_ad_groups" {
  value       = values(data.azuread_group.ad_groups)
  description = "Supplied AD Security Groups"
}

output "supplied_resource_groups" {
  value       = values(data.azurerm_resource_group.existing_rgs)
  description = "Supplied Resource Groups"
}

# output "role_assignments" {
#    #for_each = azurerm_role_assignment.*
#    value = azurerm_role_assignment.this
#    #value = each.id
#    description = " Role Assignments id"
#}
