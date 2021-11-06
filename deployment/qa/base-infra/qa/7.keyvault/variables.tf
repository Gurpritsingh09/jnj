# Key Vault

variable "resource_group_name" {
  type        = string
  description = "The Name which should be used for this Resource Group."
}

variable "pe_resource_group_name" {
  type        = string
  description = "The Name which should be used for this Resource Group."
}

variable "keyvault_name" {
  type        = string
  description = "Specifies the name of the Key vault that will be created as part of Base Infrastructure"
}

variable "soft_delete_enabled" {
  type        = bool
  description = "Allow Soft Delete be enabled for this Key Vault"
  default     = true
}

variable "purge_protection_enabled" {
  type        = bool
  description = "Allow purge_protection be enabled for this Key Vault"
  default     = true
}

variable "enabled_for_deployment" {
  type        = bool
  description = "Allow Virtual Machines to retrieve certificates stored as secrets from the key vault."
  default     = null
}

variable "enabled_for_disk_encryption" {
  type        = bool
  description = "Allow Disk Encryption to retrieve secrets from the vault and unwrap keys."
  default     = null
}

variable "enabled_for_template_deployment" {
  type        = bool
  description = "Allow Resource Manager to retrieve secrets from the key vault."
  default     = null
}

variable "sku_name" {
  type        = string
  description = "The name of the SKU used for the Key Vault. The options are: `standard`, `premium`."
  default     = "standard"
}

variable "network_acls" {
  default = null
  type    = any
}

variable "access_policies" {
  type = any
  default     = {}
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

variable "private_endpoints" {
  type = any
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}