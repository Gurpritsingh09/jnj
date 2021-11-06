data "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  for_each            = var.target_resource
  name                = each.value.resource_name
  resource_group_name = each.value.resource_group
}

module "diagnostic_setting" {

  source = "../../../../../../../modules/diagnostics/"

  for_each = data.azurerm_kubernetes_cluster.kubernetes_cluster

  diagnostic_settings_name                 = var.diagnostic_settings_name
  log_analytics_resource_group             = var.log_analytics_resource_group
  log_analytics_workspace_name             = var.log_analytics_workspace_name
  diagnostic_storageaccount_name           = var.diagnostic_storageaccount_name
  diagnostic_storageaccount_resource_group = var.diagnostic_storageaccount_resource_group
  diagnostic_logs                          = var.diagnostic_logs
  diagnostic_metrics                       = var.diagnostic_metrics
  target_resource_id                       = each.value.id

}
