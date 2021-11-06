output "tf_test_diagnostics_settings" {
  value = [for v in module.diagnostic_setting : v.diagnostics_settings]
}
