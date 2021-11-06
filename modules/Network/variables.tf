# - Core object

variable "resource_group_name" {
  type        = string
  description = "The Name which should be used for this Resource Group."
}

variable "net_additional_tags" {
  type        = map(string)
  description = "Additional Network resources tags, in addition to the resource group tags."
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Additional Network resources tags, in addition to the resource group tags."
  default     = {}
}

# Virtual Network object

variable "virtual_networks" {
  description = "The virtal networks with their properties."
  type = map(object({
    name          = string
    address_space = list(string)
    dns_servers   = list(string)
    ddos_protection_plan = object({
      id     = string
      enable = bool
    })
  }))
  default = {}
}

variable "vnet_peering" {
  description = "Vnet Peering to the destination Vnet"
  type = map(object({
    destination_vnet_name        = string
    destination_vnet_rg          = string
    vnet_key                     = string
    allow_virtual_network_access = bool
    allow_forwarded_traffic      = bool
    allow_gateway_transit        = bool
    use_remote_gateways          = bool
  }))
  default = {}
}

# Subnet object

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

# Route Table object

variable "route_tables" {
  description = "The route tables with their properties."
  type = map(object({
    name                          = string
    disable_bgp_route_propagation = bool
    routes = list(object({
      name                   = string
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = string
    }))
  }))
  default = {}
}

# Network Security Group object

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

# Diagnostics logging

variable "nsg_log_category" {
  type = list(string)
  default = ["NetworkSecurityGroupEvent", "NetworkSecurityGroupRuleCounter"]
}

variable "vn_log_category" {
  type = list(string)
  default = ["VMProtectionAlerts"]
}

variable "diagnostics_storage_account" {
  type        = string
  description = "destination account to store audit logs"
}
 
variable "diagnostics_storage_account_rg" {
  type        = string
  description = "storage account RG for the diagnostics SA"
}

variable "log_analytics_workspace" {
  type        = map(string)
  description = "Log Analytics Workspace."
  default     = {}
}

variable "network_watcher_name" {
  type = string
  default = "" 
}

variable "network_watcher_resource_group" {
  type = string
  default = "" 
}

variable "nsg_diagnostic_setting_name" {
  type = string
  default = "nsgdiag" 
}

variable "vn_diagnostic_setting_name" {
  type = string
  default = "vndiag"
}

variable "nsg_retention_policy" {
  type = number
  default = 90
}

variable "vn_retention_policy" {
  type = number
  default = 90
}

variable "nwf_retention_policy" {
  type = number
  default = 7
}

variable "nwf_interval_in_minutes" {
  type = number
  default = 10
}



