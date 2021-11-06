# Declare all variables required for module

variable "azure_fw_name" {
  description = "Name of Azure Firewall"
  type        = string
  default     = "DSP-PRM-FW"
}

# variable "azure_fw_public_ip" {
#  description = "Public IP to be associated with Firewall"
#  type        = string
#  default     = ""
#}

variable "azure_fw_resource_group" {
  description = "Resource Group for Firewall"
  type        = string
  default     = ""
}

variable "azure_fw_location" {
  description = "Azure Region (location) for Firewall"
  type        = string
  default     = "northeurope"
}

variable "vnet_name" {
  description = "Virtual Network for Firewall Subnet"
  type        = string
  default     = ""
}

variable "fw_subnet_address_space" {
  description = "Address space for Firewall Subnet"
  type        = list(string)
}

variable "tags" {
  type        = map(string)
  description = "Tags for firewall resource"
  default     = {}
}

