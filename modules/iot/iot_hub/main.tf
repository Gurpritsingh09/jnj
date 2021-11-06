resource "azurerm_iothub" "hub" {
  name                = var.iot_hub_name
  resource_group_name = var.iot_resource_group_name
  location            = var.iot_location

  dynamic "sku" {
    for_each = var.iot_hub_sku
    content {
      name     = sku.value.name
      capacity = sku.value.capacity
    }
  }

  dynamic "file_upload" {
    for_each = var.file_uploads
    content {
      connection_string  = data.azurerm_storage_account.iothub_storage_account.primary_blob_connection_string
      container_name     = var.iot_hub_storage_container_name
      default_ttl        = file_upload.value.default_ttl
      lock_duration      = file_upload.value.lock_duration
      max_delivery_count = file_upload.value.max_delivery_count
      notifications      = file_upload.value.notifications
      sas_ttl            = file_upload.value.sas_ttl
    }
  }

  dynamic "ip_filter_rule" {
    for_each = var.iot_ip_filter_rules
    content {
      name    = ip_filter_rule.value.name
      action  = ip_filter_rule.value.action
      ip_mask = ip_filter_rule.value.ip_mask_range
    }
  }

  depends_on = [data.azurerm_storage_account.iothub_storage_account, var.iot_hub_storage_container_name]

  lifecycle {
    ignore_changes = [route]
  }

  tags = var.iot_tags
}
