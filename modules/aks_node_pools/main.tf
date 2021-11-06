resource "azurerm_kubernetes_cluster_node_pool" "node_pool" {
  for_each              = var.k8s_node_pools
  name                  = each.value["name"]
  node_count            = each.value["node_count"]
  kubernetes_cluster_id = var.aks_cluster_id
  vm_size               = each.value["vm_size"]
  os_disk_size_gb       = each.value["os_disk_size_gb"]
  os_type               = each.value["os_type"]
  enable_auto_scaling   = each.value["enable_auto_scaling"]
  min_count             = each.value["min_count"]
  max_count             = each.value["max_count"]
  vnet_subnet_id        = var.subnet_id
  node_taints           = var.node-taints
  node_labels           = var.node-labels
}
