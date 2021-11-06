resource_group_name = "EUN-DS-QA-AZF-DVC"

application_insights = {
  appinsight1 = {
    name                                  = "EUN-DS-QA-APPIN-DVC"
    application_type                      = "java"
    retention_in_days                     = 90
    daily_data_cap_in_gb                  = null
    daily_data_cap_notifications_disabled = null
    sampling_percentage                   = null
    disable_ip_masking                    = null
  }
}

tags = {
  environment  = "QA"
  region       = "eun"
  owner        = "Infra Team"
  created-by   = "Terraform Provisioned"
  team         = "Device"
  application  = "Device"
  dsep_version = "2.0"
  subscription = "Digital Surgery Platform QA EUN"
}
