resource "azurerm_app_service_plan" "app_service_plan" {
  name                = var.name
  resource_group_name = var.resource-group-name
  location            = var.location
  kind                = var.kind
  reserved            = var.reserved

  is_xenon         = false
  per_site_scaling = false

  dynamic "sku" {
    for_each = var.sku
    content {
      tier     = sku.value.tier
      size     = sku.value.size
      capacity = sku.value.capacity
    }
  }

  tags = var.tags
}
