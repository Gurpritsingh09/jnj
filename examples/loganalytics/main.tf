module "law" {
  source              = "../../modules/loganalytics/"
  inputs={
        loga={
           resource_group_name = "aks-terraform" 
           resource_group_location = "North Europe"
           log_a_ws_name = "logxtest"
        },
        loggg={
           resource_group_name = "aks-terraform" 
           resource_group_location = "North Europe"
           log_a_ws_name = "logbtest"
        }
      }
   tags = {
    environment = "npd sbx"
    owner = "Infra team"
    created-by = "Terraform Provisioned"
  }



}  

