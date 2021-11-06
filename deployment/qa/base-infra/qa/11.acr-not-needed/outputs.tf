output "tf_test_acr_name" {
  value = module.ContainerRegistry.acr_name
}

output "tf_test_acr_storage_account" {
  value = module.ContainerRegistry.acr_storage_account
}
