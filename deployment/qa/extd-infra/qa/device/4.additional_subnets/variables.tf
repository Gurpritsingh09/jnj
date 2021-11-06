#  Virtual Network 

variable "resource_group_name" {
  type        = string
  description = "The Name which should be used for this Resource Group."
}

variable "virtual_networks" {
  description = "The virtal networks with their properties."
  type        = any
}

variable "subnets" {
  description = "The virtal networks subnets with their properties."
  type        = any
}

variable "network_security_groups" {
  description = "The network security groups with their properties."
  type        = any
}

variable "route_tables" {
  description = "The route tables with their properties."
  type        = any
}
