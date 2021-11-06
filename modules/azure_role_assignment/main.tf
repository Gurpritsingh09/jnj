
#resource "azuread_group" "dsp_ad_groups" {
#  for_each = toset(var.dsp_ad_groups)
#  name     = each.value
#}

locals {
  suppliedadgroups = values(data.azuread_group.ad_groups)[*].id
  on_rgs           = values(data.azurerm_resource_group.existing_rgs)[*].id

  rg_adgroup_bindings = flatten([
    for rg in local.on_rgs : [
      for adg in local.suppliedadgroups : [
        format("%s=%s", rg, adg)
      ]
    ]
  ])
}

# Assign supplied groups to 
resource "azurerm_role_assignment" "role_assignment_at_subscription_scope" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = var.role_definition_name
  for_each             = var.applicable_at_subscription_scope ? toset(local.suppliedadgroups) : toset([])
  principal_id         = each.value
}

//resource "azurerm_role_assignment" "role_assignment_at_mgmt_group_scope" {
//  for_each             = var.applicable_at_mgmt_grp_scope ? toset(local.suppliedadgroups) : toset([])
//  scope                = data.azurerm_management_group.management_group.id
//  role_definition_name = var.role_definition_name
//  principal_id         = each.value
//}

resource "azurerm_role_assignment" "role_assignment_at_rg_scope" {

  for_each = var.applicable_at_resource_grp_scope ? toset(local.rg_adgroup_bindings) : toset([])

  scope                = split("=", each.key)[0]
  role_definition_name = var.role_definition_name
  principal_id         = split("=", each.value)[1]
}

