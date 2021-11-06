## template variables

variable "name" {
  type        = string
  description = "storage account name"
}

variable "resource_group_name" {
  type        = "string"
  description = "resource group to place SA into"
}

variable "location" {
  type        = "string"
  description = "azure region"
  default     = "northeurope"
}

variable "account_tier" {
  type        = "string"
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium"
  default     = "Standard"
}

variable "account_kind" {
  type        = "string"
  description = "Defines the Kind of account. Valid options are Storage, StorageV2 and BlobStorage"
  default     = "StorageV2"
}

variable "access_tier" {
  type        = "string"
  description = "Defines the access tier for BlobStorage and StorageV2 accounts. Valid options are Hot and Cool"
  default     = "Hot"
}

variable "enable_https_traffic_only" {
  type        = "string"
  description = "Boolean flag which forces HTTPS if enabled"
  default     = "true"
}

variable "is_hns_enabled" {
  type        = "string"
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2"
  default     = "false"
}

variable "account_replication_type" {
  type        = "string"
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS and ZRS"
  default     = "GRS"
}

variable "network_bypass" {
  type        = "list"
  description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None."
  default     = ["None"]
}

variable "ip_rules" {
  type        = "list"
  description = "List of IP or IP ranges in CIDR Format."
  default     = []
}

variable "virtual_network_subnet_ids" {
  type        = "list"
  description = "A list of resource ids for subnets."
  default     = []
}

variable "default_action" {
  type        = "string"
  description = "defaultAction for storage accoutn netRuleSet"
  default     = "Allow"
}

variable "tags" {
  type        = "map"
  description = "tags"
}
