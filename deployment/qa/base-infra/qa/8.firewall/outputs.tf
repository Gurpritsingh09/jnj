output "firewall_id" {
  description = "Display created DSP Firewall"
  value       = module.firewall.firewall_id
}
output "firewall_subnet" {
  value = module.firewall.network_subnet_id
}
output "firewall_public_ip" {
  value = module.firewall.firewall_public_ip
}

output "tf_test_azurerm_firewall_name" {
  value = module.firewall.azurerm_firewall_name
}

output "tf_test_azurerm_firewall_location" {
  value = module.firewall.azurerm_firewall_location
}

output "tf_test_azurerm_firewall_ip_configuration_name" {
  value = module.firewall.azurerm_firewall_ip_configuration_name
}
