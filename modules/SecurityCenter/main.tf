resource "azurerm_security_center_workspace" "security_center" {
  scope        = data.azurerm_subscription.primary.id
  workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
}
