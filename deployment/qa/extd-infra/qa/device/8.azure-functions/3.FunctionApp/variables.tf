# ### ============ common vars
variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "resource-group-name" {
  description = "(Required) The name of the resource group in which to create the Azure Function component."
}

variable "location" {
  description = "azure region"
  default     = "northeurope"
}

# ### ============ AppService Plan
variable "app-service-plan-name" {
  description = "(Required) Name of Azure App Service Plan where Azure Function will run"
}

variable "sku" {
  description = "(Required) Set tier and size for App Service Plan"
  type = map(object({
    tier     = string
    size     = string
    capacity = number
  }))
}

variable "kind" {
  description = "Type of AppService Plan to create. Defaults to FunctionApp"
}

variable "reserved" {
  description = "Should this be a reserved instance? Refer to https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan for detailed usage. Defaults to true."
  default     = true
}

# ### ============ Azure Functions
variable "functions" {
  description = "(Required) Set required parameters per Azure Function"
  type = map(object({
    name    = string
    version = string
    os-type = string
  }))
}

# ### ============ data lookup variables
variable "subnet-name" {
  description = "(Required) Name of the subnet"
}

variable "vnet-name" {
  description = "(Required) Name of the Virtual Network"
}

variable "network-rg" {
  description = "(Required) Name of resource group where network assets reside"
}

variable "appinsights-name" {
  description = "(Required) Name of the Application Insights resource"
}

variable "sa-name" {
  description = "(Required) Name of the Storage Account dedicated for Azure Function app"
}

variable "sa-rg" {
  description = "(Required) Name of resource group where storage assets reside"
}

variable "uaid-name" {
  description = "(Required) Name of the user-assigned managed identity to use"
}
