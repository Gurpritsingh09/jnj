variable "eventhub-resource-group-name" {
  description = "Target EventHub resource group name"
}

variable "eventhub-namespace-name" {
  description = "Target EventHub namespace name"
}

variable "eventhub-eventhub-name" {
  description = "Target EventHub eventhub name"
}

variable "eventhub-auth-rule-name" {
  description = "Target EventHub authorization rule name"
}

variable "iot_hub_endpoint_name" {
  description = "End Point Name to be created"
}

variable "iot_resource_group_name" {
  description = "Resource group to put the iot hub in"
}

variable "iot_hub_name" {
  description = "The name of the iot hub resource"
}

variable "iothub-route-name" {
  description = " Provide all routes applicable for IOT Hub to the specified end point"
}

variable "iothub-route-source" {
  description = " Provide all routes applicable for IOT Hub to the specified end point"
}

variable "iothub-route-condition" {
  description = " Provide all routes applicable for IOT Hub to the specified end point"
}

variable "iothub-route-enabled" {
  description = " Provide all routes applicable for IOT Hub to the specified end point"
  default     = "True"
}
