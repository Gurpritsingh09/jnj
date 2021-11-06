# Storage Account
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account"
}

variable "storage_accounts" {
  type        = any
  description = "Map of storage accouts which needs to be created in a resource group"
}

variable "containers" {
  type        = any
  description = "Map of Storage Containers"
  default     = {}
}

variable "blobs" {
  type        = any
  description = "Map of Storage Blobs"
  default     = {}
}

variable "queues" {
  type        = any
  description = "Map of Storages Queues"
  default     = {}
}

variable "file_shares" {
  type        = any
  description = "Map of Storages File Shares"
  default     = {}
}

variable "tables" {
  type        = any
  description = "Map of Storage Tables"
  default     = {}
}

variable "sa_vn_name" {
  type        = string
  description = "VNET for storage account network rules"
}

variable "restrict_public_access" {
  type        = bool
  description = "Restrict public internet access and allow access only from vnet/subnets"
}

# Private Endpoint
variable "private_endpoints" {
  type = any
}

variable "pe_resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "specific_subnets" {
  type    = list(string)
  default = []
}

### additional data lookup variables
variable "keyvault_name" {
  description = "KeyVault name"
}

variable "keyvault_resource_group" {
  description = "KeyVault resource group name"
}
