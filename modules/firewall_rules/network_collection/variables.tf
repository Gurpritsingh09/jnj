# Declare all variables required for module

variable "azure_fw_rule_collection_name" {
  description = "Name of Azure Firewall Rules"
  type        = string
  default     = "DSP-PRM-FW-Rule-1"
}

variable "azure_fw_rule_colllection_priority"{
  description  = "Priority of Rule, usually a number starting from 100"
  type         = number
  default      = 500

}

variable "azure_fw_rule_collection_action"{
  description  = "Action against Rule, for e.g. Allow or Deny"
  type         = string
  default      = "Deny"

}

variable "azure_fw_name" {
  description = "Name of Azure Firewall to which Rule Collection will be associated to"
  type        = string
  default     = "DSP-PRM-FW"
}


variable "azure_fw_resource_group" {
  description = "Resource Group for Firewall to be associated with Rule Collection"
  type        = string
  default     = ""
}

variable "azure_fw_rule_name" {
  description = "Rule Name(Preferably in Upper Case) in the collection. For e.g. HTTP,Web,Internal etc"
  type        = string
  default     = "HTTP"
}

variable "azure_fw_rule_source_address" {
  description = "Source Addresses to be applied against the rule"
  type        = list(string)
  default     = []
}

variable "azure_fw_rule_destination_address" {
  description = "Destination Address to be applied against the rule against the source addresses"
  type        = list(string)
  default     = []
}

variable "azure_fw_rule_destination_ports" {
  description = "Destination Port against Destination Address"
  type        = list(string)
  default     = []
}

variable "azure_fw_rule_protocols" {
  description = "Traffic Protocols . For e.g. TCP,UDP etc"
  type        = list(string)
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags for firewall resource"
  default     = {}
}

# - Firewall Network Rules object

variable "firewall_network_rules" {
  description   = "The firewall network rules properties."
  type = list(object({
       name                      = string
       source_addresses          = list(string)
       destination_ports         = list(string)
       destination_addresses     = list(string)
       protocols                 = list(string)
    }))
  default = []
}

