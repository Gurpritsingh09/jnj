//data "azurerm_management_group" "management_group" {
//  name  = var.mgmt_group
//}

data "azurerm_subscription" "primary" {
}

data "azurerm_client_config" "example" {
}

data "azuread_group" "ad_groups" {
  for_each = toset(var.ad_groups)
  name     = each.value
}

data "azurerm_resource_group" "existing_rgs" {
  for_each = toset(var.rgs)
  name     = each.value
}
