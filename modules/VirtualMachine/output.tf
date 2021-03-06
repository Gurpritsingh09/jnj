
# - Linux VM's

output "linux_vm_resource_group_names" {
  value = [for x in azurerm_linux_virtual_machine.linux_vms : x.resource_group_name]
}

output "linux_vm_names" {
  value = [for x in azurerm_linux_virtual_machine.linux_vms : x.name]
}

output "linux_vm_ids" {
  value = [for x in azurerm_linux_virtual_machine.linux_vms : x.id]
}

output "linux_vm_private_ip_address" {
  value = [for x in azurerm_linux_virtual_machine.linux_vms : x.private_ip_address]
}

output "linux_vm_public_ip_address" {
  value = [for x in azurerm_linux_virtual_machine.linux_vms : x.public_ip_address]
}

output "linux_vm_nicid_map" {
  value = zipmap(
    [for x in azurerm_linux_virtual_machine.linux_vms : x.name],
    [for x in azurerm_network_interface.linux_nics : x.id]
  )
}

output "linux_vm_id_map" {
  value = { for x in azurerm_linux_virtual_machine.linux_vms : x.name => x.id }
}

output "linux_vm_identity_map" {
  value = { for x in azurerm_linux_virtual_machine.linux_vms : x.name => x.identity.*.principal_id }
}

