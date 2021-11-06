variable "diagnostic_settings_name" {
  type        = string
  description = "The name of the diagnostic setting"
}
variable "target_resource_id" {
  description = "Specifies the ID of the Resource on which to configure Diagnostic Settings"
}
variable "log_analytics_resource_group" {
  type        = string
  description = "The Log analytics resource group"
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "The Log analytics workspace to send logs to."
}

variable "diagnostic_storageaccount_name" {
  type        = string
  description = "Specifies the resource group of the storage account where Diagnostics Data should be sent"
}

variable "diagnostic_storageaccount_resource_group" {
  description = "Specifies the name of the storage account where Diagnostics Data should be sent"
}


variable "diagnostic_logs" {
  type        = list(object({ category = string, enabled = bool, retention_policy = object({ enabled = bool, days = number }) }))
  description = "An array of diagnostic logs to configure."
}

variable "diagnostic_metrics" {
  type        = list(object({ category = string, enabled = bool, retention_policy = object({ enabled = bool, days = number }) }))
  description = "An array of diagnostic metrics to configure."
}

variable "skip_archive" {
  type        = string
  description = "Option to skip archiving to a storage account"
  default     = "false"
}
