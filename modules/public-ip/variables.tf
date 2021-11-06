# Declare all variables required for module


variable "public_ip_name" {
  description = "Name of Azure Public IP resource"
  type        = string
  default     = "AzurePublicIP"
}


variable "public_ip_resource_group" {
  description = "Resource Group to host Public IP "
  type        = string
}

variable "public_ip_location" {
  description = "Azure Region (location) for Public IP"
  type        = string
  default     = "northeurope"
}

variable "public_ip_allocation_method" {
  description = "Allocation Method for Public IP"
  type        = string
  default     = "Static"
}

variable "public_ip_sku" {
  description = "SKU for  Public IP "
  type        = string
  default     = "Standard"
}

variable "public_ip_tags" {
  type        = map(string)
  description = "Tags for  Public IP "
  default     = {}
}

