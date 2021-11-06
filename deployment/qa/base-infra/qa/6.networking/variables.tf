#  Virtual Network 

variable "resource_group_name" {
  type        = string
  description = "The Name which should be used for this Resource Group."
}

variable "virtual_networks" {
  description = "The virtal networks with their properties."
  type = any
}

variable "subnets" {
  description = "The virtal networks subnets with their properties."
  type = any
}

variable "route_tables" {
  description = "The route tables with their properties."
  type = any
}

variable "network_security_groups" {
  description = "The network security groups with their properties."
  type = any
}

variable "diagnostics_storage_account" {
  type        = string
  description = "destination account to store audit logs"
}
 
variable "diagnostics_storage_account_rg" {
  type        = string
  description = "storage account RG for the diagnostics SA"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

