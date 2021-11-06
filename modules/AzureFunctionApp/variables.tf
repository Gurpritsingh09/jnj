variable "function-name" {
  description = "Name of Azure Function App"
}

variable "resource-group-name" {
  description = "(Required) The name of the resource group in which to create the Azure Function component."
}

variable "location" {
  description = "azure region"
  default     = "northeurope"
}

variable "app-service-plan-id" {
  description = "App Service Plan ID in which Function App will run"
}

variable "function-os-type" {
  description = "(Required) Type of function os runtime"
}

variable "identity-id" {
  # type        = list(string)
  description = "IDs of User Assigned Managed Identities to be used by Azure Function to authenticate with the rest of the assets"
}

variable "azure-function-version" {
  default = "~3"
}

variable "application-insights-instrumentation-key" {
  description = "Application Insights instance instrumentation key with which to connect the Azure Function App"
}

variable "storage-account-name" {
  description = "(Required) The name of the storage account for Azure Function component."
}

variable "storage-account-key" {
  description = "(Required) The key for the storage account for Azure Function component."
}

variable "destination-subnet-id" {
  description = "ID of subnet where Azure Function will be placed"
}

variable "tags" {
  type        = map(string)
  description = "Tags for Azure Function App resource"
  default     = {}
}
