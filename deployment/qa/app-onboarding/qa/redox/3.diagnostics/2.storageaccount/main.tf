data "azurerm_storage_account" "storage_account" {
  count               = length(var.target_resource)
  name                = element([for ele in var.target_resource : ele.resource_name], count.index)
  resource_group_name = element([for ele in var.target_resource : ele.resource_group], count.index)
}

locals {
  merge_objects = [for ele in data.azurerm_storage_account.storage_account : merge(ele, { skip_archive = var.target_resource[index([for tr in var.target_resource : tr.resource_name], ele.name)].skip_archive })]
}

module "diagnostic_setting" {

  source = "../../../../../../../modules/diagnostics/"
  count  = length(local.merge_objects)

  diagnostic_settings_name                 = var.diagnostic_settings_name
  log_analytics_resource_group             = var.log_analytics_resource_group
  log_analytics_workspace_name             = var.log_analytics_workspace_name
  diagnostic_storageaccount_name           = var.diagnostic_storageaccount_name
  diagnostic_storageaccount_resource_group = var.diagnostic_storageaccount_resource_group
  diagnostic_logs                          = var.diagnostic_logs
  diagnostic_metrics                       = var.diagnostic_metrics
  target_resource_id                       = local.merge_objects[count.index].id
  skip_archive                             = local.merge_objects[count.index].skip_archive

}

module "diagnostic_setting_blob" {

  source = "../../../../../../../modules/diagnostics/"

  count = length(local.merge_objects)

  diagnostic_settings_name                 = var.diagnostic_settings_name
  log_analytics_resource_group             = var.log_analytics_resource_group
  log_analytics_workspace_name             = var.log_analytics_workspace_name
  diagnostic_storageaccount_name           = var.diagnostic_storageaccount_name
  diagnostic_storageaccount_resource_group = var.diagnostic_storageaccount_resource_group
  diagnostic_logs                          = var.diagnostic_logs_bfqt
  diagnostic_metrics                       = var.diagnostic_metrics
  target_resource_id                       = "${local.merge_objects[count.index].id}/blobServices/default/"
  skip_archive                             = local.merge_objects[count.index].skip_archive
  depends_on = [
    module.diagnostic_setting
  ]
}

module "diagnostic_setting_file" {

  source = "../../../../../../../modules/diagnostics/"

  count = length(local.merge_objects)

  diagnostic_settings_name                 = var.diagnostic_settings_name
  log_analytics_resource_group             = var.log_analytics_resource_group
  log_analytics_workspace_name             = var.log_analytics_workspace_name
  diagnostic_storageaccount_name           = var.diagnostic_storageaccount_name
  diagnostic_storageaccount_resource_group = var.diagnostic_storageaccount_resource_group
  diagnostic_logs                          = var.diagnostic_logs_bfqt
  diagnostic_metrics                       = var.diagnostic_metrics
  target_resource_id                       = "${local.merge_objects[count.index].id}/fileServices/default/"
  skip_archive                             = local.merge_objects[count.index].skip_archive
  depends_on = [
    module.diagnostic_setting_blob
  ]
}

module "diagnostic_setting_queue" {

  source = "../../../../../../../modules/diagnostics/"

  count = length(local.merge_objects)

  diagnostic_settings_name                 = var.diagnostic_settings_name
  log_analytics_resource_group             = var.log_analytics_resource_group
  log_analytics_workspace_name             = var.log_analytics_workspace_name
  diagnostic_storageaccount_name           = var.diagnostic_storageaccount_name
  diagnostic_storageaccount_resource_group = var.diagnostic_storageaccount_resource_group
  diagnostic_logs                          = var.diagnostic_logs_bfqt
  diagnostic_metrics                       = var.diagnostic_metrics
  target_resource_id                       = "${local.merge_objects[count.index].id}/queueServices/default/"
  skip_archive                             = local.merge_objects[count.index].skip_archive
  depends_on = [
    module.diagnostic_setting_file
  ]
}

module "diagnostic_setting_table" {

  source = "../../../../../../../modules/diagnostics/"

  count = length(local.merge_objects)

  diagnostic_settings_name                 = var.diagnostic_settings_name
  log_analytics_resource_group             = var.log_analytics_resource_group
  log_analytics_workspace_name             = var.log_analytics_workspace_name
  diagnostic_storageaccount_name           = var.diagnostic_storageaccount_name
  diagnostic_storageaccount_resource_group = var.diagnostic_storageaccount_resource_group
  diagnostic_logs                          = var.diagnostic_logs_bfqt
  diagnostic_metrics                       = var.diagnostic_metrics
  target_resource_id                       = "${local.merge_objects[count.index].id}/tableServices/default/"
  skip_archive                             = local.merge_objects[count.index].skip_archive
  depends_on = [
    module.diagnostic_setting_queue
  ]
}
