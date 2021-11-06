variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Azure CosmosDB"
}

variable "location" {
  type        = "string"
  description = "Region to deploy service(s) into"
  default     = "northeurope"
}

variable "application_insights" {
  type = any
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
}
