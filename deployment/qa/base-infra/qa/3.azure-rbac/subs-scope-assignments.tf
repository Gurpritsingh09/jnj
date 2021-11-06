module "ad_role_assignment_at_qa_subscription_scope_owner" {
  source = "../../../../../modules/azure_role_assignment/"

  ad_groups                        = ["EUN-DS-QA-SUB-Owner"]
  rgs                              = []
  role_definition_name             = "Owner"
  applicable_at_subscription_scope = true
}


module "ad_role_assignment_at_qa_subscription_scope_contributor" {
  source = "../../../../../modules/azure_role_assignment/"

  ad_groups                        = ["EUN-DS-QA-SUB-Contributor"]
  rgs                              = []
  role_definition_name             = "Contributor"
  applicable_at_subscription_scope = true
}

module "ad_role_assignment_at_qa_subscription_scope_reader" {
  source = "../../../../../modules/azure_role_assignment/"

  ad_groups                        = ["EUN-DS-QA-SUB-Reader"]
  rgs                              = []
  role_definition_name             = "Reader"
  applicable_at_subscription_scope = true
}

