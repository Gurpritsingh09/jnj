
output "resource_groups" {
  value = module.resource_groups.output_resource_groups
}

output "tf_test_resource_groups_names" {
  value = module.resource_groups.resource_group_names
}
