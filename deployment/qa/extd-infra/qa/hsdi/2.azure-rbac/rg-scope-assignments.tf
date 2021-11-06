module "ad_role_assignment_at_HSDI_cluster_Admin" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-HSDI-AKS-Admins"]
  rgs                              = ["EUN-DS-QA-AKS-HSDI"]
  role_definition_name             = "Azure Kubernetes Service Cluster Admin Role"
  applicable_at_resource_grp_scope = true
  mgmt_group                       = "DSPMgmtGrpRel0.2"
}

module "ad_role_assignment_at_HSDI_cluster_Contributor" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-HSDI-AKS-Contributor"]
  rgs                              = ["EUN-DS-QA-AKS-HSDI"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
  mgmt_group                       = "DSPMgmtGrpRel0.2"
}

module "ad_role_assignment_at_HSDI_cluster_Reader" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-HSDI-AKS-Reader"]
  rgs                              = ["EUN-DS-QA-AKS-HSDI"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
  mgmt_group                       = "DSPMgmtGrpRel0.2"
}

### STORAGE ACCOUNTS
module "ad_role_assignment_at_rg-HSDI_STG_reader" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-HSDI-STG-Reader"]
  rgs                              = ["EUN-DS-QA-STG-HSDI"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg-HSDI_STG_contributor" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-HSDI-STG-Contributor"]
  rgs                              = ["EUN-DS-QA-STG-HSDI"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}


### SQL role

module "ad_role_assignment_at_rg_QA-HSDI-SQL_contributor" {
  source = "../../../../../../modules/azure_role_assignment/"

  ad_groups                        = ["EUN-DS-QA-HSDI-SQL-Contributor"]
  rgs                              = ["EUN-DS-QA-SQL-HSDI"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-HSDI-SQL_reader" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-HSDI-SQL-Reader"]
  rgs                              = ["EUN-DS-QA-SQL-HSDI"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}
