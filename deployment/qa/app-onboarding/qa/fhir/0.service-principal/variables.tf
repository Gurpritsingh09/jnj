variable "tenant_app_spn" {
  type        = list(string)
  description = "List of service principal names"
}

variable "kv_name" {
  type        = string
  description = "infra env key vault name"
  default     = null
}

variable "kv_rg" {
  type        = string
  description = "infra env key vault rg"
  default     = null
}

variable "mfa_ad_group" {
  type        = string
  description = "AD group name to add SP in."
}
