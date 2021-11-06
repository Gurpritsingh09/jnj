variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the Application Insights component."
}
/*
variable "location" {
  type        = "string"
  description = "azure region"
  default     = "northeurope"
}
*/
variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

# ApplicationInsights

variable "application_insights" {
  type = map(object({
    name                                  = string
    application_type                      = string
    retention_in_days                     = number
    daily_data_cap_in_gb                  = number
    daily_data_cap_notifications_disabled = bool
    sampling_percentage                   = number
    disable_ip_masking                    = bool
  }))
  description = "Map containing Application Insights details"
  default     = {}
}


