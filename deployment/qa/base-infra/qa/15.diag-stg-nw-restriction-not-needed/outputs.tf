output "tf_test_sa_account_tier" {
  value = azurerm_storage_account.sa.account_tier
}

output "tf_test_sa_account_kind" {
  value = azurerm_storage_account.sa.account_kind
}

output "tf_test_sa_is_hns_enabled" {
  value = azurerm_storage_account.sa.is_hns_enabled
}

output "tf_test_sa_name" {
  value = azurerm_storage_account.sa.name
}
