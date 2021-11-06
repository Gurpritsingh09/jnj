variable "adusers" {
  type = list(object({
    user_principal_name = string
    display_name        = string
  }))
  description = "List of service principal names"
}


variable "keyvault_name" {
  type        = string
  description = "Name of the keyvault to store the SP pass"
}

variable "keyvault_rg" {
  type        = string
  description = "Resource group name of the keyvault to store the SP pass"
}

variable "mfa_ad_group" {
  type        = string
  description = "AD group name to add SP in."
}
