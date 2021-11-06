#Query for resource group
data "azurerm_resource_group" "aksrg" {
  name = var.resource_group_name
}
#Query for vault,secret
data "azurerm_key_vault" "mgmtkeyvault" {
  name                = var.mgmt_key_vault_name
  resource_group_name = var.mgmt_key_vault_rg
}

data "azurerm_key_vault_secret" "aks_server_app_id" {
  name         = var.aks_server_app_id
  key_vault_id = data.azurerm_key_vault.mgmtkeyvault.id
}

data "azurerm_key_vault_secret" "aks_server_app_secret" {
  name         = var.aks_server_app_secret
  key_vault_id = data.azurerm_key_vault.mgmtkeyvault.id
}

data "azurerm_key_vault_secret" "aks_client_app_id" {
  name         = var.aks_client_app_id
  key_vault_id = data.azurerm_key_vault.mgmtkeyvault.id
}
data "azurerm_key_vault_secret" "aks_tenant_id" {
  name         = var.aks_tenant_id
  key_vault_id = data.azurerm_key_vault.mgmtkeyvault.id
}
data "azurerm_key_vault_secret" "sp_client_aks" {
  name         = var.aks_sp_client
  key_vault_id = data.azurerm_key_vault.mgmtkeyvault.id
}
data "azurerm_key_vault_secret" "sp_client_secret_aks" {
  name         = var.aks_sp_client_secret
  key_vault_id = data.azurerm_key_vault.mgmtkeyvault.id
}
data "azurerm_subnet" "subid" {
  name                 = var.adv_subnet_name
  virtual_network_name = var.vnet_name_aks
  resource_group_name  = var.subnet_rg
}

#aks cluster creation starts
resource "azurerm_kubernetes_cluster" "this" {
  name                = var.k8s_cluster.name
  resource_group_name = data.azurerm_resource_group.aksrg.name
  location            = data.azurerm_resource_group.aksrg.location
  dns_prefix          = var.k8s_cluster.dns_prefix
  kubernetes_version  = var.k8s_cluster.kubernetes_version
  tags                = var.tags

  default_node_pool {
    name            = var.k8s_default_pool.name
    node_count      = var.k8s_default_pool.node_count
    vm_size         = var.k8s_default_pool.vm_size
    os_disk_size_gb = var.k8s_default_pool.os_disk_size_gb
    type            = "VirtualMachineScaleSets"
    #availability_zones  = var.k8s_default_pool.availability_zones
    enable_auto_scaling = var.k8s_default_pool.enable_auto_scaling
    # orchestrator_version = var.k8s_cluster.kubernetes_version
    min_count      = var.k8s_default_pool.min_count
    max_count      = var.k8s_default_pool.max_count
    vnet_subnet_id = data.azurerm_subnet.subid.id
  }

  service_principal {
    client_id     = data.azurerm_key_vault_secret.sp_client_aks.value
    client_secret = data.azurerm_key_vault_secret.sp_client_secret_aks.value
  }


  addon_profile {
    oms_agent {
      enabled                    = data.azurerm_log_analytics_workspace.log_analytics_workspace.id != null ? true : false
      log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
    }
    kube_dashboard {
      enabled = false
    }
    azure_policy {
      enabled = var.azure_policy_enabled
    }
  }

  network_profile {
    network_plugin     = var.network_profile.network_plugin
    network_policy     = var.network_profile.network_policy
    load_balancer_sku  = var.network_profile.load_balancer_sku
    docker_bridge_cidr = var.network_profile.docker_bridge_cidr
    service_cidr       = var.network_profile.service_cidr
    dns_service_ip     = var.network_profile.dns_service_ip
  }


  role_based_access_control {
    enabled = "true"

    azure_active_directory {
      client_app_id     = data.azurerm_key_vault_secret.aks_client_app_id.value
      server_app_id     = data.azurerm_key_vault_secret.aks_server_app_id.value
      server_app_secret = data.azurerm_key_vault_secret.aks_server_app_secret.value
      tenant_id         = data.azurerm_key_vault_secret.aks_tenant_id.value
    }
  }

}
#Node-pool start here
resource "azurerm_kubernetes_cluster_node_pool" "node_pools" {
  name                  = var.k8s_node_pool.name
  node_count            = var.k8s_node_pool.node_count
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = var.k8s_node_pool.vm_size
  os_disk_size_gb       = var.k8s_node_pool.os_disk_size_gb
  enable_auto_scaling   = true
  # orchestrator_version  = var.k8s_cluster.kubernetes_version
  min_count      = var.k8s_node_pool.min_count
  max_count      = var.k8s_node_pool.max_count
  vnet_subnet_id = data.azurerm_subnet.subid.id

}

/*
  addon_profile {
    oms_agent {
      enabled                    = var.log_analytics_workspace_id != null ? true : false
      log_analytics_workspace_id = var.log_analytics_workspace_}
    }
    kube_dashboard {
      enabled = true
    }
  }

data "azurerm_log_analytics_workspace" "logworkspace" {
  name                = var.aks_log_analytics_workspace_name
  resource_group_name = var.aks_log_analytics_rg
}


data "azurerm_storage_account" "example" {
  name                = var.aks_log_storage_name
  resource_group_name = var.aks_storage_resource_group
}
resource "azurerm_monitor_diagnostic_setting" "log_analytics" {
  name                       = var.aks_log_analytics_diagnostic_name
  target_resource_id         = azurerm_kubernetes_cluster.this.id
  storage_account_id = data.azurerm_storage_account.example.id

  log {
    category = "kube-audit"
    enabled  = true
    retention_policy {
      enabled = true
    }
  }
  log {
    category = "kube-apiserver"
    enabled  = true
    retention_policy {
      enabled = true
    }
  }
  log {
    category = "kube-controller-manager"
    enabled  = true
    retention_policy {
      enabled = true
    }
  }
  log {
    category = "kube-scheduler"
    enabled  = true
    retention_policy {
      enabled = true
    }
  }
  log {
    category = "cluster-autoscaler"
    enabled  = true
    retention_policy {
      enabled = true
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
    }
  }

  lifecycle {
    ignore_changes = [metric, log, target_resource_id]
  }
}



*/
