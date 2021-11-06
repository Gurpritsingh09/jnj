# - Create resource groups

resource "azurerm_resource_group" "resource_groups" {

  for_each = toset(var.resource_groups)
  name     = each.value

  location = var.location
  tags     = var.rg_tags
}
