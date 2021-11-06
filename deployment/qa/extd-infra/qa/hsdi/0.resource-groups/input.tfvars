resource_groups = [
  "EUN-DS-QA-STG-HSDI",
  "EUN-DS-QA-SQL-HSDI",
  "EUN-DS-QA-AKS-HSDI"
]

location = "North Europe"

tags = {
  environment  = "QA"
  region       = "eun"
  owner        = "Infra Team"
  created-by   = "Terraform Provisioned"
  team         = "HSDI"
  application  = "Orthanc, Dicom"
  dsep_version = "2.0"
  subscription = "Digital Surgery Platform QA EUN"
}
