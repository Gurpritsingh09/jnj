# Create Network Rules for DSP NPD Firewall

module "dsp_firewall_network_rules" {

  source                             = "../../../../../../modules/firewall_rules/network_collection"
  azure_fw_rule_collection_name      = "DS-QA-NWK"
  azure_fw_name                      = "DS-QA-PRM-FW"
  azure_fw_resource_group            = "EUN-DS-QA-NWK-SH"
  azure_fw_rule_colllection_priority = 100
  azure_fw_rule_collection_action    = "Allow"
  firewall_network_rules = [
    {
      name                  = "Inbound"
      source_addresses      = ["172.27.0.0/16"]
      destination_ports     = ["*"]
      destination_addresses = ["*"]
      protocols             = ["TCP", "UDP"]
    },
    {
      name                  = "VPN"
      source_addresses      = ["10.223.0.0/16"]
      destination_ports     = ["*"]
      destination_addresses = ["*"]
      protocols             = ["TCP", "UDP"]
    },
    {
      name                  = "Outbound"
      source_addresses      = ["10.190.0.0/16"]
      destination_ports     = ["*"]
      destination_addresses = ["*"]
      protocols             = ["TCP", "UDP"]
    }

  ] # End of Rules


} # End of Module
