
module "dsp_firewall_nat_rules" {

  source                        = "../../../../../../modules/firewall_rules/nat_collection"
  azure_fw_rule_collection_name = "DS-QA-NAT"
  azure_fw_name                 = "DS-QA-PRM-FW"
  azure_fw_resource_group       = "EUN-DS-QA-NWK-SH"
  azure_fw_public_ip_name       = "ds-qa-prm-fw-pip"
  #  resource_group_name =  "NA-DS-NPD-NWK-SH"

  azure_fw_rule_colllection_priority = 100
  azure_fw_rule_collection_action    = "Dnat"
  firewall_network_rules = [
    {
      name              = "JNJ-Inbound"
      source_addresses  = ["35.229.101.178", "170.251.192.190", "35.237.38.106", "137.135.78.150", "104.211.41.150", "104.16.0.0/12", "103.21.244.0/22", "141.101.64.0/18", "52.255.222.51", "162.158.0.0/15", "131.0.72.0/22", "173.245.48.0/20", "148.177.0.0/16", "52.150.53.119", "172.64.0.0/13", "108.162.192.0/18", "52.147.210.196", "199.65.0.0/16", "103.22.200.0/22", "103.31.4.0/22", "197.234.240.0/22", "52.224.151.12", "188.114.96.0/20", "52.142.33.96", "198.41.128.0/17", "190.93.240.0/20"]
      destination_ports = ["443"]
      #destination_addresses = [local.ds-npd-fw-aks-pip]
      translated_address = "10.190.227.4"
      translated_port    = 443
      protocols          = ["TCP"]
    },
    {
      name              = "Mirth"
      source_addresses  = ["35.229.101.178", "170.251.192.190", "35.237.38.106", "137.135.78.150", "104.211.41.150", "104.16.0.0/12", "103.21.244.0/22", "141.101.64.0/18", "52.255.222.51", "162.158.0.0/15", "131.0.72.0/22", "173.245.48.0/20", "148.177.0.0/16", "52.150.53.119", "172.64.0.0/13", "108.162.192.0/18", "52.147.210.196", "199.65.0.0/16", "103.22.200.0/22", "103.31.4.0/22", "197.234.240.0/22", "52.224.151.12", "188.114.96.0/20", "52.142.33.96", "198.41.128.0/17", "190.93.240.0/20"]
      destination_ports = ["8443"]
      #destination_addresses = [local.ds-npd-fw-aks-pip]
      translated_address = "10.190.227.4"
      translated_port    = 8443
      protocols          = ["TCP"]
    },
    {
      name              = "Hospital-SIM-QA"
      source_addresses  = ["35.229.101.178", "170.251.192.190", "35.237.38.106", "137.135.78.150", "104.211.41.150", "104.16.0.0/12", "103.21.244.0/22", "141.101.64.0/18", "52.255.222.51", "162.158.0.0/15", "131.0.72.0/22", "173.245.48.0/20", "148.177.0.0/16", "52.150.53.119", "172.64.0.0/13", "108.162.192.0/18", "52.147.210.196", "199.65.0.0/16", "103.22.200.0/22", "103.31.4.0/22", "197.234.240.0/22", "52.224.151.12", "188.114.96.0/20", "52.142.33.96", "198.41.128.0/17", "190.93.240.0/20"]
      destination_ports = ["13005"]
      #destination_addresses = [local.ds-npd-fw-aks-pip]
      translated_address = "10.190.48.250"
      translated_port    = 13005
      protocols          = ["TCP", "UDP"]
    },
    {
      name              = "Apigee"
      source_addresses  = ["3.83.34.63", "54.152.206.217", "18.207.225.218", "54.87.238.48", "54.198.17.236", "34.227.32.27", "54.90.188.195", "54.167.231.181", "52.44.180.242", "75.101.132.183", "34.246.224.4", "34.250.54.8", "54.210.253.22", "54.210.253.17", "52.51.76.203", "52.209.180.201"]
      destination_ports = ["443"]
      #destination_addresses = [local.ds-npd-fw-aks-pip]
      translated_address = "10.190.227.4"
      translated_port    = 443
      protocols          = ["TCP"]
    }
  ] # End of Rules

} # End of Module
