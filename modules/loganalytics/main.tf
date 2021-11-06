
resource "azurerm_log_analytics_workspace" "example" {
  for_each = var.inputs
  name                = each.value.log_a_ws_name
  location            = each.value.resource_group_location
  resource_group_name = each.value.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                 = var.tags 
}
