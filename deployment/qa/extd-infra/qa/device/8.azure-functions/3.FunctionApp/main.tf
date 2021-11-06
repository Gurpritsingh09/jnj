module "AppServicePlan" {
  source = "../../../../../../../modules/AzureAppServicePlan"

  resource-group-name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  name     = var.app-service-plan-name
  kind     = var.kind
  reserved = var.reserved
  sku      = var.sku
  tags     = var.tags
}

module "AzureFunction" {
  source = "../../../../../../../modules/AzureFunctionApp"

  for_each               = var.functions
  function-name          = each.value.name
  function-os-type       = each.value.os-type
  azure-function-version = each.value.version

  resource-group-name                      = var.resource-group-name
  location                                 = var.location
  app-service-plan-id                      = module.AppServicePlan.app-service-plan-id
  identity-id                              = data.azurerm_user_assigned_identity.function-uaid.id
  application-insights-instrumentation-key = data.azurerm_application_insights.this.instrumentation_key
  storage-account-name                     = data.azurerm_storage_account.this.name
  storage-account-key                      = data.azurerm_storage_account.this.primary_access_key
  destination-subnet-id                    = data.azurerm_subnet.subnet.id
  tags                                     = var.tags

  depends_on = [
    module.AppServicePlan
  ]
}
