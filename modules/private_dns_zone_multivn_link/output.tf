output "dns_zone" {
    value = azurerm_private_dns_zone.private_dns_zones
}

output "dns_zone_links" {
    value = [for x in azurerm_private_dns_zone_virtual_network_link.dns_zones_virtul_network_links : x] 
}