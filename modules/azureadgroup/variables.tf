# Declare all variables required for module

variable "azuread_security_groups" {
  description = "azuread security groups"
  type        = list(string)
  default     = ["ds-qa-mg-owner", "ds-qa-mg-contributor", "ds-qa-mg-reader"]
}

#
# variable "dsp_mgmt_group" {
#  description ="Identifies Management Group for the Tenant"
#  type        = string
#  default     = "DSP_MgmtGrp_QA"

#}
