# -  IOT HUB  DSP inputs

variable "resource_group_name" {
  description = "Resource group hosting IOT HUB"
}

variable "location" {
  description = "location/region of iot hub "
}

variable "iot_hub_name" {
  description = "The name of the iot hub resource"
}

variable "iot_dps_name" {
  description = "The name of the IoT Hub DPS resource to be created"
}

variable "iot_tags" {
  type        = map(string)
  description = "Tags for IOT HUB DSP resource"
  default     = {}
}

variable "iothub_dps_sku" {
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
