data "azurerm_eventhub_authorization_rule" "evhub-auth-rule" {
  name                = var.eventhub-auth-rule-name
  namespace_name      = var.eventhub-namespace-name
  eventhub_name       = var.eventhub-eventhub-name
  resource_group_name = var.eventhub-resource-group-name
}
