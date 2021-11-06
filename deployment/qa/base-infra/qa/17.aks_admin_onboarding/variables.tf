variable "aks_admin_spn" {
    type = string
    default = null
}

variable "aks_admin_spn_adgroups" {
    type = list(string)
    default = []
}