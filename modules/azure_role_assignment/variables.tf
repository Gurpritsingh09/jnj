
variable "mgmt_group" {
  description ="The Management Group for the Tenant to which a role will be assigned to AD group"
  type        = string
  default     = "DSP_MgmtGrp_QA"
}

variable "rgs"{
  description = "List of RGs scope to which a role will be given to AD groups"
  type = list(string)
}

variable "ad_groups" {
 description = "List of existing Azure AD groups on which Role will be applied to"
 type = list(string)

}

variable "role_definition_name"{
 description = " One of the Azure BuiltInRole Roles - For e.g. Owner,Reader,Contributor,AcrPull,AcrPush,AcrDelete,AcrImageSigner,AcrQuarantineReader,AcrQuarantineWriter etc. "
 type = string
}

variable "applicable_at_subscription_scope" {
  description = "If set to true, assign supplied AD groups to Roles at Subscription Scope"
  type        = bool
  default     = false
}

variable "applicable_at_mgmt_grp_scope" {
  description = "If set to true, assign supplied AD groups to Roles at Management Group Scope"
  type        = bool
  default     = false
}

variable "applicable_at_resource_grp_scope" {
  description = "If set to true, assign supplied AD groups to Roles at Management Group Scope"
  type        = bool
  default     = false
}

