variable "log_analytics_resource_group" {
  type        = string
  description = "LOG A resource group name"
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "LOG A workspace name"
}

variable "resource_types" {
  type        = list(string)
  description = "Resource types for Standard plan"
}
