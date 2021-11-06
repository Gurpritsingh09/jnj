variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account"
}

variable "tags" {
  type        = map(string)
  description = "Tags of the SA in addition to the resource group tag."
}

variable "eventhub_name" {
  type        = string
  description = "Specifies the name of the eventhub"
}

variable "hubs" {
  type = any
}
variable "eventhub_vn_name" {
  type        = string
  description = "VNET for eventhub network rules"
}
variable "restrict_public_access" {
  type        = bool
  description = "Restrict public internet access and allow access only from vnet/subnets"
}
variable "auto_inflate" {
  type        = object({ enabled = bool, maximum_throughput_units = number })
  description = "Set eventhub auto inflate"
}

variable "capacity" {
  type        = number
  description = "Capacity for event hub"
}
# Private Endpoins
variable "pe_resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account"
}


variable "private_endpoints" {
  type = any
}

