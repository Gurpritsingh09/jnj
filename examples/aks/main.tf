module "aks" {
  source              = "../../modules/AKS/"
  resource_group_name = "aks-terraform"
  mgmt_key_vault_name = "akskeyvaults"
  mgmt_key_vault_rg   = "aks-terraform"
  aks_server_app_id   = "aadserver"
  aks_client_app_id   = "aadclient"
  aks_server_app_secret = "aksecrets"
  aks_tenant_id = "aadtenant"
  aks_sp_client = "spaksclient"
  aks_sp_client_secret = "spakssecret"
  k8s_cluster = {
    name = "terraform-aks-tes"
    dns_prefix = "terraformaks"
    kubernetes_version = "1.17.7"
  }
  k8s_default_pool = {
    name            = "terraformks"
    node_count      = 2
    vm_size         = "Standard_D2s_v3"
    os_disk_size_gb = 100
    enable_auto_scaling = true
    min_count       = 1
    max_count       = 4

  }
  
  
  k8s_node_pool = {
    name            = "kubenodes1"
    node_count      = 2
    vm_size         = "Standard_D2s_v3"
    os_disk_size_gb = 100
    enable_auto_scaling = true
    min_count       = 1
    max_count       = 4      
  }
  



  tags = {
    environment = "terraform-test"
    owner ="Infra team"
    created-by="shamanth"
  }



}  