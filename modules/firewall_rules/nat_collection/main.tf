# Create a Azure Firewall NAT Rule Collection

resource "azurerm_firewall_nat_rule_collection" "firewall_nat_rule_collection" {
  name = var.azure_fw_rule_collection_name
  azure_firewall_name = data.azurerm_firewall.azure_fw_name.name
  resource_group_name = data.azurerm_resource_group.fw_rg.name
  priority = var.azure_fw_rule_colllection_priority
  action = var.azure_fw_rule_collection_action


  dynamic "rule" {
    for_each = var.firewall_network_rules
    content {
      name                   = lookup(rule.value, "name", null)
      source_addresses       = lookup(rule.value, "source_addresses", null)
      destination_ports      = lookup(rule.value, "destination_ports", null)
      destination_addresses  = [data.azurerm_public_ip.azure_firewall_public_ip.ip_address]
      translated_address     = lookup(rule.value, "translated_address", null)
      translated_port        = lookup(rule.value, "translated_port", null)
      protocols              = lookup(rule.value, "protocols", null)
    }
  }
}
