variable "resource_group_name" {
  description = "(Required) resource group name of private dns zone."
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

# Private DNS Zone

variable "private_dns_zones" {
  type = map(object({
    dns_zone_name            = string
    zone_exists              = bool
    zone_to_vnet_link_exists = bool
    registration_enabled     = bool
  }))
  description = "Map containing Private DNS Zone Objects"
  default     = {}
}

variable "vnet_ids" {
  type        = string
  description = "A map of vnet id's"
}
