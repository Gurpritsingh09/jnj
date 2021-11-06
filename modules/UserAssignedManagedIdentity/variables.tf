variable "resource-group-name" {
  description = "(Required) The name of the resource group in which to create the Azure Function component."
}

variable "location" {
  description = "azure region"
  default     = "northeurope"
}

variable "name" {
  description = "(Required) Name of the user-assigned managed identity"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
}
