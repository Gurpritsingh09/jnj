resource "azurerm_security_center_subscription_pricing" "dsp" {
  for_each      = toset(var.resource_types)
  tier          = "Standard"
  resource_type = each.value
}


# Enable security center
module "security_center" {
  source                       = "../../../../../modules/SecurityCenter/"
  log_analytics_resource_group = var.log_analytics_resource_group
  log_analytics_workspace_name = var.log_analytics_workspace_name

}

