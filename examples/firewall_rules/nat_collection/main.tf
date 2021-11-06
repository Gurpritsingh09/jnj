
module "firewall_nat_rules" {

   source                                   = "../../../modules/firewall_rules/nat_collection"
   azure_fw_rule_collection_name            = "terraform-test-nat-collection"
   azure_fw_name                            = "DSP-PRM-FW-Terraform"
   azure_fw_resource_group                  = "NA-DS-NPD-NWK-SH"
   azure_fw_rule_colllection_priority       = 401
   azure_fw_rule_collection_action          = "Dnat"
   firewall_network_rules                   = [
						{
						 name="NAT-Terraform"
                                                 source_addresses=["10.0.0.0/16"]
						 destination_ports = ["443"]
						 destination_addresses = ["*"]
						 translated_address = "10.58.32.5"
						 translated_port = 8443
						 protocols = ["TCP","UDP"]
						}
						

					      ]





}
