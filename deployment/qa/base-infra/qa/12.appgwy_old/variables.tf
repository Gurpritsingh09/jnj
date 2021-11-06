variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Application Gateway component."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
}

variable "application_gateways" {
  type    = any
  description = "Map containing Application Gateways details"
}

variable "waf_policies" {
  type    = any
  description = "Map containing Web Application Firewall details"
}
