module "ad_role_assignment_at_rg_QA-NWK_contributor" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-PRM-Contributor"]
  rgs                              = ["EUN-DS-QA-NWK-SH"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-NWK_network_reader" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-PRM-Reader"]
  rgs                              = ["EUN-DS-QA-NWK-SH"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

#  ---  Assign roles to Reader,Contributor,AcrPull,AcrPush,AcrImageSigner,AcrQuarantineReader,AcrQuarantineWriter 

module "ad_role_assignment_at_rg_QA-DATA-ACR_contributor" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DATA-ACR-Contributor"]
  rgs                              = ["EUN-DS-QA-ACR-DATA"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-DATA-ACR_reader" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DATA-ACR-Reader"]
  rgs                              = ["EUN-DS-QA-ACR-DATA"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-DATA-ACR_pull" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DATA-ACR-Pull"]
  rgs                              = ["EUN-DS-QA-ACR-DATA"]
  role_definition_name             = "AcrPull"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-DATA-ACR_push" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DATA-ACR-Push"]
  rgs                              = ["EUN-DS-QA-ACR-DATA"]
  role_definition_name             = "AcrPush"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-DATA-ACR_signer" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DATA-ACR-Signer"]
  rgs                              = ["EUN-DS-QA-ACR-DATA"]
  role_definition_name             = "AcrImageSigner"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-DATA-ACR_qreader" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DATA-ACR-QuarantineRead"]
  rgs                              = ["EUN-DS-QA-ACR-DATA"]
  role_definition_name             = "AcrQuarantineReader"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-DATA-ACR_qwriter" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DATA-ACR-QuarantineWrite"]
  rgs                              = ["EUN-DS-QA-ACR-DATA"]
  role_definition_name             = "AcrQuarantineWriter"
  applicable_at_resource_grp_scope = true
}



#--- THIS PART MISSING IN DD ---  Assign

module "ad_role_assignment_at_rg_QA-FHR-ACR_contributor" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-FHR-ACR-Contributor"]
  rgs                              = ["EUN-DS-QA-ACR-FHR"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-FHR-ACR_reader" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-FHR-ACR-Reader"]
  rgs                              = ["EUN-DS-QA-ACR-FHR"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-FHR-ACR_pull" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-FHR-ACR-Pull"]
  rgs                              = ["EUN-DS-QA-ACR-FHR"]
  role_definition_name             = "AcrPull"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-FHR-ACR_push" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-FHR-ACR-Push"]
  rgs                              = ["EUN-DS-QA-ACR-FHR"]
  role_definition_name             = "AcrPush"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-FHR-ACR_signer" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-FHR-ACR-Signer"]
  rgs                              = ["EUN-DS-QA-ACR-FHR"]
  role_definition_name             = "AcrImageSigner"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-FHR-ACR_qreader" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-FHR-ACR-QuarantineRead"]
  rgs                              = ["EUN-DS-QA-ACR-FHR"]
  role_definition_name             = "AcrQuarantineReader"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-FHR-ACR_qwriter" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-FHR-ACR-QuarantineWrite"]
  rgs                              = ["EUN-DS-QA-ACR-FHR"]
  role_definition_name             = "AcrQuarantineWriter"
  applicable_at_resource_grp_scope = true
}


# ---  Assign roles to Reader,Contributor  on RG = EUN-DS-QA-KEY-SH

module "ad_role_assignment_at_rg_QA-KEY_reader" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-KEY-Reader"]
  rgs                              = ["EUN-DS-QA-KEY-SH"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-KEY_contributor" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-KEY-Contributor"]
  rgs                              = ["EUN-DS-QA-KEY-SH"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-HSDI-KEY_reader" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-HSDI-KEY-Reader"]
  rgs                              = ["EUN-DS-QA-KEY-HSDI"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-HSDI-KEY_contributor" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-HSDI-KEY-Contributor"]
  rgs                              = ["EUN-DS-QA-KEY-HSDI"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

# ---  Assign roles to Reader,Contributor  on RG = EUN-DS-QA-STG-SH

module "ad_role_assignment_at_rg_QA-STG_reader" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-STG-Reader"]
  rgs                              = ["EUN-DS-QA-STG-SH"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-STG_contributor" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-STG-Contributor"]
  rgs                              = ["EUN-DS-QA-STG-SH"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-STG_blbown" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-STG-BLB-Owner"]
  rgs                              = ["EUN-DS-QA-STG-SH"]
  role_definition_name             = "Storage Blob Data Owner"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-STG_blbcon" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-STG-BLB-Contributor"]
  rgs                              = ["EUN-DS-QA-STG-SH"]
  role_definition_name             = "Storage Blob Data Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-STG_blbrd" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-STG-BLB-Reader"]
  rgs                              = ["EUN-DS-QA-STG-SH"]
  role_definition_name             = "Storage Blob Data Reader"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-STG_fscon" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-STG-File-Contributor"]
  rgs                              = ["EUN-DS-QA-STG-SH"]
  role_definition_name             = "Storage File Data SMB Share Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-STG_fsrd" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-STG-File-Reader"]
  rgs                              = ["EUN-DS-QA-STG-SH"]
  role_definition_name             = "Storage File Data SMB Share Reader"
  applicable_at_resource_grp_scope = true
}
#----------------------------------------------------------------
module "ad_role_assignment_at_rg_QA-DATA-STG_reader" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DATA-STG-Reader"]
  rgs                              = ["EUN-DS-QA-STG-DATA"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-DATA-STG_contributor" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DATA-STG-Contributor"]
  rgs                              = ["EUN-DS-QA-STG-DATA"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-DATA-STG_blbown" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DATA-STG-BLB-Owner"]
  rgs                              = ["EUN-DS-QA-STG-DATA"]
  role_definition_name             = "Storage Blob Data Owner"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-DATA-STG_blbcon" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DATA-STG-BLB-Contributor"]
  rgs                              = ["EUN-DS-QA-STG-DATA"]
  role_definition_name             = "Storage Blob Data Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-DATA-STG_blbrd" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DATA-STG-BLB-Reader"]
  rgs                              = ["EUN-DS-QA-STG-DATA"]
  role_definition_name             = "Storage Blob Data Reader"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-DATA-STG_fscon" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DATA-STG-File-Contributor"]
  rgs                              = ["EUN-DS-QA-STG-DATA"]
  role_definition_name             = "Storage File Data SMB Share Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-DATA-STG_fsrd" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DATA-STG-File-Reader"]
  rgs                              = ["EUN-DS-QA-STG-DATA"]
  role_definition_name             = "Storage File Data SMB Share Reader"
  applicable_at_resource_grp_scope = true
}

# ---  Assign roles on RG EUN-DS-QA-AKS-VELYS

module "ad_role_assignment_at_rg_AKS-QA_contributor" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-VELYS-AKS-Contributor"]
  rgs                              = ["EUN-DS-QA-AKS-VELYS"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_AKS-QA_reader" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-VELYS-AKS-Reader"]
  rgs                              = ["EUN-DS-QA-AKS-VELYS"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

#  ---  Assign roles to Reader,Contributor  on RG EUN-DS-QA-LGA-SH

module "ad_role_assignment_at_rg_QA-LGA_contributor" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-LGA-Contributor"]
  rgs                              = ["EUN-DS-QA-LGA-SH"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-LGA_reader" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-LGA-Reader"]
  rgs                              = ["EUN-DS-QA-LGA-SH"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

# ---  Assign roles on RG EUN-DS-QA-AKS-DATA

module "ad_role_assignment_at_rg_QA-DFL-contributor" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DATA-AKS-Contributor"]
  rgs                              = ["EUN-DS-QA-AKS-DATA"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-DFL-reader" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DATA-AKS-Reader"]
  rgs                              = ["EUN-DS-QA-AKS-DATA"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

# ---  Assign roles 

module "ad_role_assignment_at_rg_QA-DATA-SQL_contributor" {
  source = "../../../../../modules/azure_role_assignment/"

  ad_groups                        = ["EUN-DS-QA-DATA-SQL-Contributor"]
  rgs                              = ["EUN-DS-QA-SQL-DATA"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-DATA-SQL_reader" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DATA-SQL-Reader"]
  rgs                              = ["EUN-DS-QA-SQL-DATA"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

# ---  Assign roles 

module "ad_role_assignment_at_rg_QA-FHR-SQL_contributor" {
  source = "../../../../../modules/azure_role_assignment/"

  ad_groups                        = ["EUN-DS-QA-FHR-SQL-Contributor"]
  rgs                              = ["EUN-DS-QA-SQL-FHR"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-FHR-SQL_reader" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-FHR-SQL-Reader"]
  rgs                              = ["EUN-DS-QA-SQL-FHR"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

# ---  Assign roles

module "ad_role_assignment_at_rg_QA-VELYS-SQL_contributor" {
  source = "../../../../../modules/azure_role_assignment/"

  ad_groups                        = ["EUN-DS-QA-VELYS-SQL-Contributor"]
  rgs                              = ["EUN-DS-QA-SQL-VELYS"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-VELYS-SQL_reader" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-VELYS-SQL-Reader"]
  rgs                              = ["EUN-DS-QA-SQL-VELYS"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

# ---  Assign roles on RG EUN-DS-QA-EVT-VELYSRSK

module "ad_role_assignment_at_rg_QA-EVT_contributer" {
  source = "../../../../../modules/azure_role_assignment/"

  ad_groups                        = ["EUN-DS-QA-VELYSRSK-EVT-Contributor"]
  rgs                              = ["EUN-DS-QA-EVT-VELYSRSK"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_QA-EVT_reader" {
  source = "../../../../../modules/azure_role_assignment/"

  ad_groups                        = ["EUN-DS-QA-VELYSRSK-EVT-Reader"]
  rgs                              = ["EUN-DS-QA-EVT-VELYSRSK"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

# ---  Assign roles on RG EUN-DS-QA-AKS-FHR

module "ad_role_assignment_at_rg_FHR-QA_contributor" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-FHR-AKS-Contributor"]
  rgs                              = ["EUN-DS-QA-AKS-FHR"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_FHR-QA_reader" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-FHR-AKS-Reader"]
  rgs                              = ["EUN-DS-QA-AKS-FHR"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}

#Azure Kubernetes Services (AKS) admin RBAC

module "ad_role_assignment_at_AFL_QA_cluster_Admin" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-DATA-AKS-Admins"]
  rgs                              = ["EUN-DS-QA-AKS-DATA"]
  role_definition_name             = "Azure Kubernetes Service Cluster Admin Role"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_FHR_QA_cluster_Admin" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-FHR-AKS-Admins"]
  rgs                              = ["EUN-DS-QA-AKS-FHR"]
  role_definition_name             = "Azure Kubernetes Service Cluster Admin Role"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_AKS_QA_cluster_Admin" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-VELYS-AKS-Admins"]
  rgs                              = ["EUN-DS-QA-AKS-VELYS"]
  role_definition_name             = "Azure Kubernetes Service Cluster Admin Role"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_VMS-QA_contributor" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-VMSS-Contributor"]
  rgs                              = ["EUN-DS-QA-VMS-SH"]
  role_definition_name             = "Contributor"
  applicable_at_resource_grp_scope = true
}

module "ad_role_assignment_at_rg_VMS-QA_reader" {
  source                           = "../../../../../modules/azure_role_assignment/"
  ad_groups                        = ["EUN-DS-QA-VMSS-Reader"]
  rgs                              = ["EUN-DS-QA-VMS-SH"]
  role_definition_name             = "Reader"
  applicable_at_resource_grp_scope = true
}



