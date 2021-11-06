# - Core object

variable "resource_group_name" {
  type        = string
  description = "The Name which should be used for this Resource Group."
}

variable "virtual_networks" {
  description = "The virtal networks with their properties."
  type = map(object({
    name = string
  }))
  default = {}
}

variable "subnets" {
  description = "The virtal networks subnets with their properties."
  type = map(object({
    name              = string
    vnet_key          = string
    nsg_key           = string
    rt_key            = string
    address_prefixes  = list(string)
    pe_enable         = bool
    service_endpoints = list(string)
    delegation = list(object({
      name = string
      service_delegation = list(object({
        name    = string
        actions = list(string)
      }))
    }))
  }))
  default = {}
}

variable "network_security_groups" {
  description = "The network security groups with their properties."
  type = map(object({
    name = string
    security_rules = list(object({
      name                                         = string
      description                                  = string
      protocol                                     = string
      direction                                    = string
      access                                       = string
      priority                                     = number
      source_address_prefix                        = string
      source_address_prefixes                      = list(string)
      destination_address_prefix                   = string
      destination_address_prefixes                 = list(string)
      source_port_range                            = string
      source_port_ranges                           = list(string)
      destination_port_range                       = string
      destination_port_ranges                      = list(string)
      source_application_security_group_names      = list(string)
      destination_application_security_group_names = list(string)
    }))
  }))
  default = {}
}

variable "app_security_group_ids_map" {
  type        = map(string)
  description = "Specifies the Map of Application Security Group Id's"
  default     = {}
}

variable "route_tables" {
  description = "The route tables with their properties."
  type        = any
  default     = {}
}
