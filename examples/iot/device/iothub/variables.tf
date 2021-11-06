# IOT HUB inputs

variable "iot_resource_group_name" {
  description = "Resource group to put the iot hub in"
}

variable "iot_location" {
  description = "location/region to put the iot hub in"
}

variable "iot_hub_name" {
  description = "The name of the iot hub resource"
}

variable "iot_hub_sku" {
  description = "Provide appropriate SKU details"
  type = map(object({
    name     = string
    capacity = number
  }))
  default = {
    def = {
      name     = "S1"
      capacity = 1
    }
  }
}

variable "file_uploads" {
  description = "File Upload properties"
  type = map(object({
    default_ttl        = string
    lock_duration      = string
    max_delivery_count = number
    notifications      = bool
    sas_ttl            = string
  }))
  default = {
    file_up = {
      default_ttl        = "PT1H"
      lock_duration      = "PT1M"
      max_delivery_count = 10
      notifications      = true
      sas_ttl            = "PT1H"
    }
  }
}

variable "iot_hub_storage_resource_group_name" {
  description = "Resource Group for IOT HUB Storage Account"
}

variable "iot_hub_storage_account_name" {
  description = "Storage Account for IoT Hub"
}

variable "iot_hub_storage_container_name" {
  description = "Storage Container to host files"
}

variable "iot_tags" {
  type        = map(string)
  description = "Tags for IOT HUB resource"
  default     = {}
}

# Nice to have, but TF has some issues with it, better to leave it BLANK
variable "iot_ip_filter_rules" {
  type = list(object({
    name          = string,
    action        = string,
    ip_mask_range = string
  }))
  description = "Array of IP filter rules"
  default     = []
}

variable "endpoints" {
  type = map(object({
    endpoint-name                = string
    endpoint-route-name          = string
    endpoint-route-source        = string
    endpoint-route-condition     = string
    endpoint-route-enabled       = bool
    eventhub-resource-group-name = string
    eventhub-namespace-name      = string
    eventhub-eventhub-name       = string
    eventhub-auth-rule-name      = string
  }))
  description = "Provide details for custom endpoint and custom route to EventHub"
  default     = {}
}
