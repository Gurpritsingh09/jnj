variable "resource_groups" {
  type        = list(string)
  description = "List of Resource Groups to be created"
}

variable "location" {
  type        = string
  description = "The Azure Region"
}

variable "rg_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
