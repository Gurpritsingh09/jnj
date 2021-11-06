# variable "app-service-plan-name" {
#   description = "(Required) Name of Azure App Service Plan where Azure Function will run"
# }

variable "name" {
  description = "(Required) Name of Azure App Service Plan where Azure Function will run"
}

variable "resource-group-name" {
  description = "(Required) The name of the resource group in which to create the Azure Function component."
}

variable "location" {
  description = "(Required) Specify a location in which to start the App Service"
}

variable "sku" {
  description = "Set tier and size for App Service Plan"
  type = map(object({
    tier     = string
    size     = string
    capacity = number
  }))
  default = {
    sku1 = {
      tier     = "PremiumV3"
      size     = "P1v3"
      capacity = 1
    }
  }
}

variable "kind" {
  description = "Type of AppService Plan to create. Defaults to FunctionApp"
  default     = "linux"
}

variable "reserved" {
  description = "Should this be a reserved instance? Refer to https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan for detailed usage. Defaults to true."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Tags for AppService Plan resource"
  default     = {}
}
