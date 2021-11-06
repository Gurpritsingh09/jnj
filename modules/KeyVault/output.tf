# #############################################################################
# # OUTPUTS Key Vault
# #############################################################################

output "key_vault_id" {
  description = "The Id of the Key Vault"
  value       = azurerm_key_vault.this.id
}

output "key_vault_uri" {
  description = "The URI of the Key Vault, used for performing operations on keys and secrets"
  value       = azurerm_key_vault.this.vault_uri
}

output "key_vault" {
  description = "Key Vault details"
  value       = azurerm_key_vault.this
}

output "key_vault_policy" {
  description = "Key Vault access policy details"
  value       = azurerm_key_vault_access_policy.this
}

output "depended_on_kv" {
  value = null_resource.dependency_kv.id
}

output "key_vault_name" {
  description = "The name of the Key Vault"
  value       = azurerm_key_vault.this.name
}

output "key_vault_enabled_for_deployment" {
  description = "Key Vault enabled for deployment"
  value       = azurerm_key_vault.this.enabled_for_deployment
}

output "key_vault_enabled_for_disk_encryption" {
  description = "Key Vault enabled for encryption"
  value       = azurerm_key_vault.this.enabled_for_disk_encryption
}

output "key_vault_purge_protection_enabled" {
  description = "Key Vault enabled purge protection"
  value       = azurerm_key_vault.this.purge_protection_enabled
}

output "key_vault_soft_delete_enabled" {
  description = "Key Vault enabled for soft delete"
  value       = azurerm_key_vault.this.soft_delete_enabled
}
