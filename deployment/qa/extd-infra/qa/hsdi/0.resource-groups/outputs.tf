
output "npd_shared_resource_groups" {
  value = module.mod_dev_resource_groups.output_resource_groups
}

output "tf_test_resource_groups_names" {
  value = module.mod_dev_resource_groups.resource_group_names
}
