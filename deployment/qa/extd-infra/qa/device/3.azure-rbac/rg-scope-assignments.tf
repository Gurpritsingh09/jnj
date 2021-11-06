module "ad_role_assignment_at_DVC_cluster_Admin" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DVC-AKS-Admins"]
  rgs                              = ["EUN-DS-QA-AKS-DVC"]
  role_definition_name             = "Azure Kubernetes Service Cluster Admin Role"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_DVC_contributor" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DVC-AKS-Contributor"]
  rgs                              = ["EUN-DS-QA-AKS-DVC"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_DVC_reader" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DVC-AKS-Reader"]
  rgs                              = ["EUN-DS-QA-AKS-DVC"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

### ACR ###
module "ad_role_assignment_at_rg-ACR_contributor" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DVC-ACR-Contributor"]
  rgs                              = ["EUN-DS-QA-ACR-DVC"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg-ACR_reader" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DVC-ACR-Reader"]
  rgs                              = ["EUN-DS-QA-ACR-DVC"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg-ACR_pull" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DVC-ACR-Pull"]
  rgs                              = ["EUN-DS-QA-ACR-DVC"]
  role_definition_name             = "AcrPull"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg-ACR_push" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DVC-ACR-Push"]
  rgs                              = ["EUN-DS-QA-ACR-DVC"]
  role_definition_name             = "AcrPush"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg-ACR_signer" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DVC-ACR-Signer"]
  rgs                              = ["EUN-DS-QA-ACR-DVC"]
  role_definition_name             = "AcrImageSigner"
  applicable_at_resource_grp_scope = true
}


### KEY VAULT
module "ad_role_assignment_at_rg-KEY_reader" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DVC-KEY-Reader"]
  rgs                              = ["EUN-DS-QA-KEY-DVC"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg-KEY_contributor" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DVC-KEY-Contributor"]
  rgs                              = ["EUN-DS-QA-KEY-DVC"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

### STORAGE ACCOUNTS
module "ad_role_assignment_at_rg-STG_reader" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DVC-STG-Reader"]
  rgs                              = ["EUN-DS-QA-STG-DVC"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg-STG_contributor" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DVC-STG-Contributor"]
  rgs                              = ["EUN-DS-QA-STG-DVC"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

### SVC
module "ad_role_assignment_at_rg-SVC_contributor" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DVC-SVC-Contributor"]
  rgs                              = ["EUN-DS-QA-SVC-DVC"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg-SVC_reader" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DVC-SVC-Reader"]
  rgs                              = ["EUN-DS-QA-SVC-DVC"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

### AZF
module "ad_role_assignment_at_rg-AZF_contributor" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DVC-AZF-Contributor"]
  rgs                              = ["EUN-DS-QA-AZF-DVC"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg-AZF_reader" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DVC-AZF-Reader"]
  rgs                              = ["EUN-DS-QA-AZF-DVC"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

### EVT
module "ad_role_assignment_at_rg-EVT_contributor" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DVC-EVT-Contributor"]
  rgs                              = ["EUN-DS-QA-EVT-DVC"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg-EVT_reader" {
  source                           = "../../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DVC-EVT-Reader"]
  rgs                              = ["EUN-DS-QA-EVT-DVC"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}
