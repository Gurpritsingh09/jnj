data "azurerm_resource_group" "log_analytics_resource_group" {
  name = var.log_analytics_resource_group
}

#send logs to log analyticvs workspace
data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_resource_group
}

#To archive logs to a diagnostic storage account
data "azurerm_storage_account" "storage_account" {
  name                = var.diagnostic_storageaccount_name
  resource_group_name = var.diagnostic_storageaccount_resource_group
}