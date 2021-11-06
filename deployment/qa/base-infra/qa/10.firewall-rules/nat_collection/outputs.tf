output "dsp_firewall_nat_rules_collection" {
  value = module.dsp_firewall_nat_rules.nat_rule_collection_id
}

output "tf_test_nat_rule_collection_name" {
  value = module.dsp_firewall_nat_rules.nat_rule_collection_name
}

output "tf_test_nat_rule_collection_priority" {
  value = module.dsp_firewall_nat_rules.nat_rule_collection_priority
}
