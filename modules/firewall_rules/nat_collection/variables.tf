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
  default      = "DNAT"

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

variable "azure_fw_public_ip_name"{
   type = string
   default = "DSP-PRM-FW-Terraform-pip"
}



variable "tags" {
  type        = map(string)
  description = "Tags for firewall resource"
  default     = {}
}

# - Firewall NAT  Rules object

variable "firewall_network_rules" {
  description   = "The firewall NAT rules properties."
  type = list(object({
       name                      = string
       source_addresses          = list(string)
       destination_ports         = list(string)
       #destination_addresses     = list(string)
       translated_address        = string
       translated_port           = string
       protocols                 = list(string)
       
    }))
  default = []
}

