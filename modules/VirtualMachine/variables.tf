variable "resource_group_name" {
  type        = string
  description = "Specifies the name of the Resource Group in which the Virtual Machine should exist"
}

variable "vm_additional_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "dependencies" {
  type        = list(any)
  description = "Specifies the modules that the Virtual Machine Resource depends on."
  default     = []
}

# Linux VM's

variable "linux_vms" {
  type = map(object({
    name                             = string
    vm_size                          = string
    zone                             = string
    assign_identity                  = bool
     lb_backend_pool_names            = list(string)
    app_security_group_names         = list(string)
    disable_password_authentication  = bool
    source_image_reference_publisher = string
    source_image_reference_offer     = string
    source_image_reference_sku       = string
    source_image_reference_version   = string
    storage_os_disk_caching          = string
    managed_disk_type                = string
    disk_size_gb                     = number
    write_accelerator_enabled        = bool
    internal_dns_name_label          = string
    enable_ip_forwarding             = bool
    enable_accelerated_networking    = bool
    dns_servers                      = list(string)
    static_ip                        = string
    recovery_services_vault_key      = string
    enable_cmk_disk_encryption       = bool
    custom_data_path                 = string
    custom_data_args                 = map(string)
    diagnostics_storage_config_path  = string
    custom_script = object({
      commandToExecute   = string
      scriptPath         = string
      scriptArgs         = map(string)
      fileUris           = list(string)
      storageAccountName = string
    })
  }))
  description = "Map containing Linux VM objects"
  default     = {}
}

variable "subnet_id" {
  type        = string
  description = "Map of network interfaces subnets"
  default     = null
}

variable "lb_backend_address_pool_map" {
  type        = map(string)
  description = "Map of network interfaces internal load balancers backend pool id's"
  default     = {}
}

variable "app_security_group_ids_map" {
  type        = map(string)
  description = "Specifies the Map of network interfaces Application Security Group Id's"
  default     = {}
}

variable "key_vault_id" {
  type        = string
  description = "The Id of the Key Vault to which all secrets should be stored"
   default     = null
}

variable "administrator_user_name" {
  type        = string
  description = "Specifies the name of the local administrator account"
   default     = null
}

variable "administrator_login_password" {
  type        = string
  description = "Specifies the password associated with the local administrator account"
  default     = null
}

# Diagnostics Extensions

variable "diagnostics_sa_name" {
  type        = string
  description = "The name of diagnostics storage account"
}

variable "diagnostics_sa_rg_name" {
  type        = string
  description = "The name of diagnostics storage account resource group"
}

# Managed Disks

variable "managed_data_disks" {
  type = map(object({
    disk_name                 = string
    vm_name                   = string
    lun                       = string
    storage_account_type      = string
    disk_size                 = number
    caching                   = string
    write_accelerator_enabled = bool
  }))
  description = "Map containing storage data disk configurations"
  default     = {}
}
