# Device provisioning service
resource "azurerm_iothub_dps" "iot_hub_dps" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  /*
  sku {
    name = "S1"
    #tier     = "Standard"
    capacity = "1"
  }
 */
  dynamic "sku" {
    for_each = var.iothub_dps_sku
    content {
      name     = sku.value.name
      capacity = sku.value.capacity
    }
  }

  #Connect DPS with an existing IoT Hub using "iothub owner" shared access policy
  linked_hub {
    connection_string       = data.azurerm_iothub_shared_access_policy.iothub_iothubowner.primary_connection_string
    location                = var.location
    apply_allocation_policy = true
  }

  tags = var.iot_tags

}
