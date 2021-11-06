output "key_vault_id" {
  value = module.Keyvault.key_vault_id
}

output "key_vault" {
  value = module.Keyvault.key_vault
}

output "key_vault_policy" {
  value = module.Keyvault.key_vault_policy
}

output "tf_test_key_vault_name" {
  value = module.Keyvault.key_vault_name
}

output "tf_test_key_vault_enabled_for_deployment" {
  value = module.Keyvault.key_vault_enabled_for_deployment
}

output "tf_test_key_vault_enabled_for_disk_encryption" {
  value = module.Keyvault.key_vault_enabled_for_disk_encryption
}

output "tf_test_key_vault_purge_protection_enabled" {
  value = module.Keyvault.key_vault_purge_protection_enabled
}

output "tf_test_key_vault_soft_delete_enabled" {
  value = module.Keyvault.key_vault_soft_delete_enabled
}
