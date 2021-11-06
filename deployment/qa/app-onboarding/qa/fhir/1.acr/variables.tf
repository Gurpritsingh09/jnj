
# Container Registry

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account"
}

variable "tags" {
  type        = map(string)
  description = "Tags of the SA in addition to the resource group tag."
}

variable "acr_name" {
  type        = string
  description = "Specifies the name of the Key vault that will be created as part of Base Infrastructure"
}

variable "diagnostics_storage_account" {
  type        = string
  description = "Specifies the name of the Storage Account where Diagnostics Data should be sent"
}

variable "diagnostics_storage_account_rg" {
  type        = string
  description = "Specifies the name of the Storage Account where Diagnostics Data should be sent"
}

# Private Endpoint
variable "pe_resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account"
}

variable "private_endpoints" {
  type = any
}

