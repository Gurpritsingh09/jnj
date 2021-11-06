output "dsp_firewall_network_rules_collection" {
  value = module.dsp_firewall_network_rules.network_rule_collection_id
}
output "tf_test_network_rule_collection_name" {
  value = module.dsp_firewall_network_rules.network_rule_collection_name
}

output "tf_test_network_rule_collection_priority" {
  value = module.dsp_firewall_network_rules.network_rule_collection_priority
}
