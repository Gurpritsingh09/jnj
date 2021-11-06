output "firewall_id" {
  description = "Display created DSP Firewall"
  value       = module.firewall.firewall_id
}
output "firewall_subnet" {
   value=module.firewall.network_subnet_id
}
output "firewall_public_ip" {
   value=module.firewall.firewall_public_ip
}
