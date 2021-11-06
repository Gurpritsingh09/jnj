
output "output_resource_groups" {
  value =  values(azurerm_resource_group.resource_groups)[*].id

}

output "resource_group_names" {
   value = values(azurerm_resource_group.resource_groups)[*].name
}


