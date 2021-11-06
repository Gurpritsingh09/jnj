output "tf_test_diagnostics_settings" {
  value = values(module.diagnostic_setting)[*].diagnostics_settings
}
