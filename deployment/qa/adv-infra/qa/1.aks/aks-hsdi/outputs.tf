output "tf_test_aks_resource_id" {
  description = "Resource ID of AKS cluster"
  value       = module.aks.aks_resource_id
}

output "tf_test_aks" {
  value = module.aks.aks
}

output "tf_test_subnet_id" {
  value = module.aks.subnet_id
}
