data "azurerm_resource_group" "rg" {
  name = var.resource-group-name
}

module "UserMI" {
  source = "../../../../../../../modules/UserAssignedManagedIdentity"

  name                = var.name
  resource-group-name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  tags = var.tags
}
