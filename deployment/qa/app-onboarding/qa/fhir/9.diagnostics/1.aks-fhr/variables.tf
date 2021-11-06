variable "diagnostic_settings_name" {
  type        = string
  description = "Specifies the name of the Diagnostic Setting."
}

variable "log_analytics_resource_group" {
  type        = string
  description = "Specifies the resource group of the log analtyics where Diagnostics Data should be sent"
}

variable "log_analytics_workspace_name" {
  description = "Specifies the name of the log analtyics where Diagnostics Data should be sent"
}

variable "diagnostic_storageaccount_name" {
  type        = string
  description = "Specifies the resource group of the storage account where Diagnostics Data should be sent"
}

variable "diagnostic_storageaccount_resource_group" {
  description = "Specifies the name of the storage account where Diagnostics Data should be sent"
}

variable "target_resource" {
  description = "Specifies the resource group and name on which to configure Diagnostic Settings"
  type = map(object({
    resource_group = string
    resource_name  = string
  }))
}

variable "diagnostic_logs" {
  type = list(object({
    category = string,
    enabled  = bool,
    retention_policy = object({
      enabled = bool,
      days    = number
    })
  }))
  description = "An array of diagnostic logs to configure."
}

variable "diagnostic_metrics" {
  type = list(object({
    category = string,
    enabled  = bool,
    retention_policy = object({
      enabled = bool,
      days    = number
    })
  }))
  description = "An array of diagnostic metrics to configure."
}


