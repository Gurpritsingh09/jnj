resource "azurerm_user_assigned_identity" "function-id" {
  name                = var.name
  resource_group_name = var.resource-group-name
  location            = var.location

  tags = var.tags
}
