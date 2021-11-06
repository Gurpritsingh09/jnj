module "aks" {
  source                       = "../../../../../../modules/AKS/"
  resource_group_name          = "EUN-DS-QA-AKS-HSDI"
  mgmt_key_vault_name          = "EUN-DS-QA-VLT"
  mgmt_key_vault_rg            = "EUN-DS-QA-KEY-SH"
  log_analytics_resource_group = "EUN-DS-QA-LGA-SH"
  log_analytics_workspace_name = "DS-QA-LGA"
  aks_server_app_id            = "aadserver"
  aks_client_app_id            = "aadclient"
  aks_server_app_secret        = "aksecrets"
  aks_tenant_id                = "aadtenant"
  aks_sp_client                = "spaksclient"
  aks_sp_client_secret         = "spakssecret"
  subnet_rg                    = "EUN-DS-QA-NWK-SH"
  vnet_name_aks                = "DS-QA-VNET"
  adv_subnet_name              = "HSDI"

  k8s_cluster = {
    name               = "DS-QA-AKS-HSDI"
    dns_prefix         = "dsqaakshsdi"
    kubernetes_version = "1.19.11"
  }

  k8s_default_pool = {
    name                = "hsdiqadef"
    node_count          = 2
    vm_size             = "Standard_DS4_v2"
    os_disk_size_gb     = 100
    enable_auto_scaling = true
    min_count           = 2
    max_count           = 4
  }

  k8s_node_pool = {
    name                = "hsdiqapl"
    node_count          = 3
    vm_size             = "Standard_DS4_v2"
    os_disk_size_gb     = 100
    enable_auto_scaling = true
    min_count           = 3
    max_count           = 4
  }

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
}
