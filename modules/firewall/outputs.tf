output "network_subnet_id" {
  value = data.azurerm_subnet.AzureFirewallSubnet.id
}

output "firewall_id" {
  value       = azurerm_firewall.azure_firewall.id
  description = "DSP Firewall Id"
}

output "firewall_public_ip" {
  #  value = module.public_ip.public_ip.id
  value = data.azurerm_public_ip.public_ip.id
}

output "azurerm_firewall_name" {
  value = azurerm_firewall.azure_firewall.name
}

output "azurerm_firewall_location" {
  value = azurerm_firewall.azure_firewall.location
}

output "azurerm_firewall_ip_configuration_name" {
  value = azurerm_firewall.azure_firewall.ip_configuration[0].name
}
