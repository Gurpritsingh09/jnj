output "tf_test_aks_resource_id" {
  description = "Resource ID of AKS cluster"
  value       = module.fhr_qa_aks.aks_resource_id
}

output "tf_test_aks" {
  value = module.fhr_qa_aks.aks
}

output "tf_test_subnet_id" {
  value = module.fhr_qa_aks.subnet_id
}
