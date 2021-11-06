# Variables Container Registry

variable "name" {
  type        = string
  description = "Specifies the name of the ACR"
}

variable "location" {
  type        = "string"
  description = "azure region"
  default     = "northeurope"
}


variable "resource_group_name" {
  type        = string
  description = "Resource group to place public IP in"
}

variable "sku" {
  type        = string
  description = "Container registry sku"
  default     = "Premium"
}

variable "tags" {
  type        = map(string)
  description = "tags"
  default     = {}
}

# Variables Diagnostics Settings

variable "diagnostics_storage_account" {
  type        = "string"
  description = "destination account to store  audit logs"
}

variable "diagnostics_storage_account_rg" {
  type        = "string"
  description = "storage account RG for the diagnostics SA"
}

variable "trust_policy" {
  type        = bool
  description = "Enable/Disable trust policy for ACR images"
  default     = false
}
