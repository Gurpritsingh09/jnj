variable resource_group_name {
  type        = string
  description = "(Required) The name of the resource group in which to create the Recovery Services Vault"
}

variable "log_analytics_resource_group" {
  type        = string
  description = "Specifies the resource group of the log analtyics where Diagnostics Data should be sent"
}

variable "log_analytics_workspace_name" {
  description = "Specifies the name of the log analtyics where Diagnostics Data should be sent"
}

variable mgmt_key_vault_name {
  type        = string
  description = "Enter key-vault name"
}
variable mgmt_key_vault_rg {
  type        = string
  description = "Enter key-vault resource group"
}
variable aks_server_app_id {
  type        = string
  description = "Enter the server_app_id secret key "
}
variable aks_client_app_id {
  type        = string
  description = "Enter the client_app_id secret key "
}
variable aks_server_app_secret {
  type        = string
  description = "Enter the server_app secret key "
}

variable aks_tenant_id {
  type        = string
  description = "Enter the tenant_id secret key "
}
variable aks_sp_client {
  type        = string
  description = "Enter the service principle client secret key "
}
variable aks_sp_client_secret {
  type        = string
  description = "Enter the service principle client_secret secret key "
}
variable ad_enabled {
  type        = bool
  description = "Is ad integration enabled for the following cluster"
  default     = false
}
variable rbac_enabled {
  type        = bool
  description = "Is rbac enabled for the following cluster"
  default     = true
}
variable subnet_rg {
  type        = string
  description = "Subnet resource group in which vnet exist for adv networking"
}
variable vnet_name_aks {
  type        = string
  description = "vnet name for adv networking"

}
variable adv_subnet_name {
  type        = string
  description = "Subnet in the aks vnet exist for adv networking"

}

variable k8s_cluster {
  type = object({
    name               = string
    dns_prefix         = string
    kubernetes_version = string
  })
}

variable k8s_default_pool {
  type = object({
    name                = string
    node_count          = number
    vm_size             = string
    os_disk_size_gb     = string
    enable_auto_scaling = bool
    min_count           = number
    max_count           = number
  })
}
/*
  default = {
    name            = "Terraform_aks"
    node_count      = 2
    vm_size         = "Standard_D2s_v3"
    os_disk_size_gb = 100
    min_count       = 1
    max_count       = 4
  }

*/

variable "network_profile" {
  type = object({
    network_plugin     = string
    network_policy     = string
    docker_bridge_cidr = string
    service_cidr       = string
    load_balancer_sku  = string
    dns_service_ip     = string
  })
  default = {
    network_plugin     = "azure"
    network_policy     = "calico"
    docker_bridge_cidr = "172.17.0.1/16"
    service_cidr       = "172.16.0.0/16"
    load_balancer_sku  = "standard"
    dns_service_ip     = "172.16.0.10"
  }
}

variable "tags" {
  type        = map(string)
  description = "tags"
}

variable k8s_node_pool {
  type = object({
    name                = string
    node_count          = number
    vm_size             = string
    os_disk_size_gb     = string
    enable_auto_scaling = bool
    min_count           = number
    max_count           = number
  })

}

variable "azure_policy_enabled" {
  default = false
}
/*
  default = {
    name            = "default1"
    node_count      = 2
    vm_size         = "Standard_D2s_v3"
    os_disk_size_gb = 100
    enable_auto_scaling = true
    min_count       = 1
    max_count       = 4

  }


variable "aks_subnet_id" {
  type        = string
  description = "AKS Vnet subnet ID"
}
variable "aks_subnet_id_nodepool" {
  type        = string
  description = "AKS Vnet subnet ID"
}


variable "aks_log_storage_name" {
  type        = string
  description = "log_storage_name "
  default = "aksstorage"
}
variable "aks_storage_resource_group" {
  type        = string
  description = "aks_storage_resource_group "
  default = "aks-terraform"
}
variable log_analytics_workspace_id {
  type    = string
  default = null
}

variable aks_log_analytics_workspace_name {
  type  = string
}

variable aks_log_analytics_rg {
  type  = string
}

variable aks_log_analytics_diagnostic_name{
  type  = string
}



variable "k8s_default_pool" {
  description = "(Required in 2.0) default_pool (only one allowed in 2.6.0)"
  type        = any
}

variable "k8s_extra_node_pools" {
  description = "(Optional) List of additional node pools"
  type        = any
}

variable cloud_management_subscription {
  type    = string
  default = ""
}

*/
