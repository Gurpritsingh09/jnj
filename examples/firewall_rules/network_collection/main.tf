
module "firewall_network_rules" {

   source                                   = "../../../modules/firewall_rules/network_collection"
   azure_fw_rule_collection_name            = "terraform-nw-rules-collection"
   azure_fw_name                            = "DSP-PRM-FW-Terraform"
   azure_fw_resource_group                  = "NA-DS-NPD-NWK-SH"
   azure_fw_rule_colllection_priority       = 400
   azure_fw_rule_collection_action          = "Deny"
   firewall_network_rules                   = [
						{
						 name="HTTP-Terraform"
                                                 source_addresses=["10.0.0.0/16"]
						 destination_ports = ["80"]
						 destination_addresses = ["*"]
						 protocols = ["TCP"]
						},
					        {                                       
                                                 name="HTTPS-Terraform"
                                                 source_addresses=["10.0.0.0/16"]
                                                 destination_ports = ["443"]
                                                 destination_addresses = ["*"]
                                                 protocols = ["TCP"]
                                                },
					        {                                       
                                                 name="UDP-Terraform"
                                                 source_addresses=["10.1.0.0/16"]
                                                 destination_ports = ["4431"]
                                                 destination_addresses = ["*"]
                                                 protocols = ["UDP"]
                                                }

					      ]





}
