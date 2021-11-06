resource_groups = [
  "EUN-DS-QA-STG-DVC",
  "EUN-DS-QA-ACR-DVC",
  "EUN-DS-QA-AKS-DVC",
  "EUN-DS-QA-KEY-DVC",
  "EUN-DS-QA-SVC-DVC",
  "EUN-DS-QA-AZF-DVC",
  "EUN-DS-QA-EVT-DVC"
]

location = "North Europe"

rg_tags = {
  environment  = "QA"
  region       = "eun"
  owner        = "Infra Team"
  created-by   = "Terraform Provisioned"
  team         = "Device"
  application  = "Device"
  dsep_version = "2.0"
  subscription = "Digital Surgery Platform QA EUN"
}
