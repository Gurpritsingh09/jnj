
data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

# Storage Account Data Source for diagnostic logs

data "azurerm_storage_account" "diagnostics_storage_account" {
  name                = var.diagnostics_sa_name
  resource_group_name = var.diagnostics_sa_rg_name
  depends_on          = [null_resource.dependency_modules]
}

data "azurerm_storage_account_sas" "diagnostics_storage_account_sas" {
  connection_string = data.azurerm_storage_account.diagnostics_storage_account.primary_connection_string
  https_only        = true

  resource_types {
    service   = false
    container = true
    object    = true
  }

  services {
    blob  = true
    queue = false
    table = true
    file  = false
  }

  start  = formatdate("YYYY-MM-DD", timestamp())
  expiry = formatdate("YYYY-MM-DD", timeadd(timestamp(), "8760h"))

  permissions {
    read    = true
    write   = true
    delete  = false
    list    = true
    add     = true
    create  = true
    update  = true
    process = true
  }
}

# Get the current user config

data "azurerm_client_config" "current" {}

locals {
  tags = merge(var.vm_additional_tags, data.azurerm_resource_group.this.tags)

  vm_ids = [for x in azurerm_linux_virtual_machine.linux_vms : x.id]

  key_permissions         = ["get", "wrapkey", "unwrapkey"]
  secret_permissions      = ["get"]
  certificate_permissions = ["get"]
  storage_permissions     = ["get"]
}

# Generate Private/Public SSH Key for Linux Virtual Machine

resource "tls_private_key" "this" {
  for_each  = var.linux_vms
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Store Generated Private SSH Key to Key Vault Secrets

resource "azurerm_key_vault_secret" "this" {
  for_each     = var.linux_vms
  name         = each.value["name"]
  value        = lookup(tls_private_key.this, each.key)["private_key_pem"]
  key_vault_id = var.key_vault_id
  depends_on = [
    azurerm_key_vault_access_policy.this,
    null_resource.dependency_modules
  ]
}

# Linux Virtual Machine

resource "azurerm_linux_virtual_machine" "linux_vms" {
  for_each            = var.linux_vms
  name                = each.value["name"]
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name

  network_interface_ids = [lookup(azurerm_network_interface.linux_nics, each.key)["id"]]
  size                  = coalesce(lookup(each.value, "vm_size"), "Standard_DS1_v2")
  zone                  = lookup(each.value, "zone", null)

  disable_password_authentication = coalesce(lookup(each.value, "disable_password_authentication"), true)
  admin_username                  = var.administrator_user_name
  admin_password                  = coalesce(lookup(each.value, "disable_password_authentication"), true) == false ? var.administrator_login_password : null

  dynamic "admin_ssh_key" {
    for_each = coalesce(lookup(each.value, "disable_password_authentication"), true) == true ? [var.administrator_user_name] : []
    content {
      username   = var.administrator_user_name
      public_key = lookup(tls_private_key.this, each.key)["public_key_openssh"]
    }
  }

  os_disk {
    name                      = "${each.value["name"]}-osdisk"
    caching                   = coalesce(lookup(each.value, "storage_os_disk_caching"), "ReadWrite")
    storage_account_type      = coalesce(lookup(each.value, "managed_disk_type"), "Standard_LRS")
    disk_size_gb              = lookup(each.value, "disk_size_gb", null)
    write_accelerator_enabled = lookup(each.value, "write_accelerator_enabled", null)
    disk_encryption_set_id    = coalesce(lookup(each.value, "enable_cmk_disk_encryption"), false) == true ? lookup(azurerm_disk_encryption_set.this, each.key)["id"] : null
  }

  source_image_reference {
    publisher = lookup(each.value, "source_image_reference_publisher", null)
    offer     = lookup(each.value, "source_image_reference_offer", null)
    sku       = lookup(each.value, "source_image_reference_sku", null)
    version   = lookup(each.value, "source_image_reference_version", null)
  }

 plan {
    name      = lookup(each.value, "source_image_reference_sku", null)
    publisher = lookup(each.value, "source_image_reference_publisher", null)
    product   = lookup(each.value, "source_image_reference_offer", null)
  }

  computer_name   = each.value["name"]
  custom_data     = lookup(each.value, "custom_data_path", null) == null ? null : (base64encode(templatefile("${path.root}.${each.value["custom_data_path"]}", each.value["custom_data_args"] != null ? each.value["custom_data_args"] : {})))
  dynamic "identity" {
    for_each = coalesce(lookup(each.value, "assign_identity"), false) == false ? [] : list(coalesce(lookup(each.value, "assign_identity"), false))
    content {
      type = "SystemAssigned"
    }
  }

  tags = local.tags

  depends_on = [azurerm_disk_encryption_set.this]
}


# Linux Network Interfaces

resource "azurerm_network_interface" "linux_nics" {
  for_each                      = var.linux_vms
  name                          = "${each.value["name"]}-vm-nic"
  location                      = data.azurerm_resource_group.this.location
  resource_group_name           = data.azurerm_resource_group.this.name
  internal_dns_name_label       = lookup(each.value, "internal_dns_name_label", null)
  enable_ip_forwarding          = lookup(each.value, "enable_ip_forwarding", null)
  enable_accelerated_networking = lookup(each.value, "enable_accelerated_networking", null)
  dns_servers                   = lookup(each.value, "dns_servers", null)

  ip_configuration {
    name                          = "${each.value["name"]}-vm-nic"
    subnet_id                     =  var.subnet_id
    private_ip_address_allocation = lookup(each.value, "static_ip", null) == null ? "dynamic" : "static"
    private_ip_address            = lookup(each.value, "static_ip", null)
  }

  tags = local.tags
}

# Linux Network Interfaces - Internal Backend Pools Association

locals {
  vm_nics_map = {
    for x in azurerm_network_interface.linux_nics : x.name => x.id
  }
  linux_nics_with_internal_bp_list = flatten([
    for vm_k, vm_v in var.linux_vms : [
      for backend_pool_name in coalesce(vm_v["lb_backend_pool_names"], []) :
      {
        key                     = "${vm_k}_${backend_pool_name}"
        vm_name                 = vm_v.name
        backend_address_pool_id = lookup(var.lb_backend_address_pool_map, backend_pool_name, null)
      }
    ]
  ])
  linux_nics_with_internal_bp = {
    for bp in local.linux_nics_with_internal_bp_list : bp.key => bp
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "linux_nics_with_internal_backend_pools" {
  for_each                = local.linux_nics_with_internal_bp
  network_interface_id    = lookup(local.vm_nics_map, "${each.value["vm_name"]}-vm-nic", null)
  ip_configuration_name   = "${each.value["vm_name"]}-vm-nic"
  backend_address_pool_id = each.value["backend_address_pool_id"]
  depends_on = [
    azurerm_network_interface.linux_nics, azurerm_linux_virtual_machine.linux_vms
  ]
}

# Linux Network Interfaces - Application Security Groups Association

locals {
  linux_nics_with_asg_list = flatten([
    for vm_k, vm_v in var.linux_vms : [
      for asg_name in coalesce(vm_v["app_security_group_names"], []) :
      {
        key                           = "${vm_k}_${asg_name}"
        vm_name                       = vm_v.name
        application_security_group_id = lookup(var.app_security_group_ids_map, asg_name, null)
      }
    ]
  ])
  linux_nics_with_asg = {
    for asg in local.linux_nics_with_asg_list : asg.key => asg
  }
}

resource "azurerm_network_interface_application_security_group_association" "this" {
  for_each                      = local.linux_nics_with_asg
  network_interface_id          = lookup(local.vm_nics_map, "${each.value["vm_name"]}-vm-nic", null)
  application_security_group_id = each.value["application_security_group_id"]
}

# Create Key Vault Accesss Policy 

locals {
  msi_enabled_linux_vms = [
    for vm_k, vm_v in var.linux_vms :
    vm_v if coalesce(lookup(vm_v, "assign_identity"), false) == true
  ]

  vm_principal_ids = flatten([
    for x in azurerm_linux_virtual_machine.linux_vms :
    [
      for y in x.identity :
      y.principal_id if y.principal_id != ""
    ] if length(keys(azurerm_linux_virtual_machine.linux_vms)) > 0
  ])
}
resource "azurerm_key_vault_access_policy" "this" {
  count        = length(local.msi_enabled_linux_vms) > 0 ? length(local.vm_principal_ids) : 0
  key_vault_id = var.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = element(local.vm_principal_ids, count.index)

  key_permissions         = local.key_permissions
  secret_permissions      = local.secret_permissions
  certificate_permissions = local.certificate_permissions
  storage_permissions     = local.storage_permissions

  depends_on = [azurerm_linux_virtual_machine.linux_vms]
}

# Linux VM Managed Disk & Managed Disk Attachment

locals {
  linux_vm_ids = {
    for vm in azurerm_linux_virtual_machine.linux_vms :
    vm.name => vm.id
  }
  linux_vm_zones = {
    for vm_k, vm_v in var.linux_vms :
    azurerm_linux_virtual_machine.linux_vms[vm_k].name => vm_v.zone
  }
  linux_vms = {
    for vm_k, vm_v in var.linux_vms :
    azurerm_linux_virtual_machine.linux_vms[vm_k].name => {
      key                        = vm_k
      enable_cmk_disk_encryption = coalesce(vm_v.enable_cmk_disk_encryption, false)
    }
  }
}

# Managed Disk

resource "azurerm_managed_disk" "this" {
  for_each            = var.managed_data_disks
  name                = lookup(each.value, "disk_name", null) == null ? "${each.value["vm_name"]}-datadisk-${each.value["lun"]}" : each.value["disk_name"]
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name

  zones                  = list(lookup(local.linux_vm_zones, each.value["vm_name"], null))
  storage_account_type   = coalesce(lookup(each.value, "storage_account_type"), "Standard_LRS")
  disk_encryption_set_id = lookup(lookup(local.linux_vms, each.value["vm_name"]), "enable_cmk_disk_encryption") == true ? lookup(azurerm_disk_encryption_set.this, lookup(lookup(local.linux_vms, each.value["vm_name"]), "key"))["id"] : null
  disk_size_gb           = coalesce(lookup(each.value, "disk_size"), 1)
  create_option          = "Empty"
  os_type                = "Linux"

  tags       = local.tags
  depends_on = [azurerm_linux_virtual_machine.linux_vms, azurerm_disk_encryption_set.this]
}

# Linux VM - Managed Disk Attachment

resource "azurerm_virtual_machine_data_disk_attachment" "this" {
  for_each                  = var.managed_data_disks
  managed_disk_id           = lookup(lookup(azurerm_managed_disk.this, each.key, null), "id", null)
  virtual_machine_id        = lookup(local.linux_vm_ids, each.value["vm_name"])
  lun                       = coalesce(lookup(each.value, "lun"), "10")
  caching                   = coalesce(lookup(each.value, "caching"), "ReadWrite")
  write_accelerator_enabled = lookup(each.value, "write_accelerator_enabled", null)
}

# Linux VM Extension

locals {
  linux_vm_diag_storage = {
    for vm_k, vm_v in var.linux_vms :
    azurerm_linux_virtual_machine.linux_vms[vm_k].id => vm_v.diagnostics_storage_config_path
  }

  diagnostics_storage_config_parms = {
    storage_account  = data.azurerm_storage_account.diagnostics_storage_account.name
    log_level_config = "LOG_DEBUG"
  }

}


# Enabling Network Watcher extension on Azure Linux VM 

resource "azurerm_virtual_machine_extension" "network_watcher" {
  count                      = length(local.vm_ids)
  name                       = "network-watcher"
  virtual_machine_id         = element(local.vm_ids, count.index)
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type                       = "NetworkWatcherAgentLinux"
  type_handler_version       = "1.4"
  auto_upgrade_minor_version = true
  depends_on                 = [azurerm_linux_virtual_machine.linux_vms]
}


# Linux VM CMK and Disk Encryption Set

locals {
  cmk_enabled_virtual_machines = {
    for vm_k, vm_v in var.linux_vms :
    vm_k => vm_v if coalesce(lookup(vm_v, "enable_cmk_disk_encryption"), false) == true
  }
}

# Generate CMK Key for Linux VM

resource "null_resource" "dependency_modules" {
  provisioner "local-exec" {
    command = "echo ${length(var.dependencies)}"
  }
}
resource "azurerm_key_vault_key" "this" {
  for_each     = local.cmk_enabled_virtual_machines
  name         = each.value.name
  key_vault_id = var.key_vault_id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt", "encrypt", "sign",
    "unwrapKey", "verify", "wrapKey"
  ]

  depends_on = [null_resource.dependency_modules]
}

# Enable Disk Encryption Set for Linux VM using CMK

resource "azurerm_disk_encryption_set" "this" {
  for_each            = local.cmk_enabled_virtual_machines
  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  key_vault_key_id    = lookup(azurerm_key_vault_key.this, each.key)["id"]
  identity {
    type = "SystemAssigned"
  }
}

# Adding Access Policies for Disk Encryption 

resource "azurerm_key_vault_access_policy" "cmk" {
  for_each     = local.cmk_enabled_virtual_machines
  key_vault_id = var.key_vault_id

  tenant_id = lookup(azurerm_disk_encryption_set.this, each.key).identity.0.tenant_id
  object_id = lookup(azurerm_disk_encryption_set.this, each.key).identity.0.principal_id

  key_permissions    = local.key_permissions
  secret_permissions = local.secret_permissions
}

# Assigning Reader Role to Disk Encryption 

resource "azurerm_role_assignment" "this" {
  for_each                         = local.cmk_enabled_virtual_machines
  scope                            = var.key_vault_id
  role_definition_name             = "Reader"
  principal_id                     = lookup(azurerm_disk_encryption_set.this, each.key).identity.0.principal_id
  skip_service_principal_aad_check = true
}


