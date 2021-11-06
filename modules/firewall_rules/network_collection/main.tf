# Create a Azure Firewall Network Rule Collection

resource "azurerm_firewall_network_rule_collection" "firewall_network_rule_collection" {
  name = var.azure_fw_rule_collection_name
  azure_firewall_name = data.azurerm_firewall.azure_fw_name.name
  resource_group_name = data.azurerm_resource_group.fw_rg.name
  priority = var.azure_fw_rule_colllection_priority
  action = var.azure_fw_rule_collection_action

#  rule {
#    name = var.azure_fw_rule_name
#    source_addresses = var.azure_fw_rule_source_address
#    destination_ports = var.azure_fw_rule_destination_ports
#    destination_addresses = var.azure_fw_rule_destination_address
#    protocols = var.azure_fw_rule_protocols
#  }

  dynamic "rule" {
    for_each = var.firewall_network_rules
    content {
      name                   = lookup(rule.value, "name", null)
      source_addresses       = lookup(rule.value, "source_addresses", null)
      destination_ports      = lookup(rule.value, "destination_ports", null)
      destination_addresses  = lookup(rule.value, "destination_addresses", null)
      protocols              = lookup(rule.value, "protocols", null)
    }
  }
}
