data "azuread_service_principal" "aks_admin_spn" {
  display_name = var.aks_admin_spn
}