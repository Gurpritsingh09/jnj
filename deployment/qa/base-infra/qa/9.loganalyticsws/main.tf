provider "azurerm" {
  features {}
}

module "mod_loganalyticsworkspace" {
  source = "../../../../../modules/loganalytics"
  inputs = {
    loga = {
      resource_group_name     = "EUN-DS-QA-LGA-SH"
      resource_group_location = "North Europe"
      log_a_ws_name           = "DS-QA-LGA"
    }

  }
  tags = {
    environment = "qa"
    owner       = "Infra team"
    created-by  = "Terraform Provisioned"
  }

}
