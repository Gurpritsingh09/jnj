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

variable "dns_zone_name" {
  type        = string
  description = "Private DNS Zone Object"
}

variable "zone_to_vnet_links" {
  type = list(object({
    vn_name              = string
    vn_rg                = string
    registration_enabled = bool
  }))
  description = "A map of vnet id's"
}
