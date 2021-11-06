resource "azurerm_function_app" "function_app" {
  name                = var.function-name
  resource_group_name = var.resource-group-name
  location            = var.location

  app_service_plan_id = var.app-service-plan-id

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE"       = "",
    "APPINSIGHTS_INSTRUMENTATIONKEY" = var.application-insights-instrumentation-key,
  }

  version                    = var.azure-function-version
  os_type                    = var.function-os-type
  storage_account_name       = var.storage-account-name
  storage_account_access_key = var.storage-account-key

  https_only = true

  identity {
    type         = "UserAssigned"
    identity_ids = [var.identity-id]
  }

  site_config {
    always_on                 = true
    websockets_enabled        = true
    http2_enabled             = false
    pre_warmed_instance_count = 0
    linux_fx_version          = "JAVA|11"
  }

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
    ]
  }

  tags = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet-attachment" {
  app_service_id = azurerm_function_app.function_app.id
  subnet_id      = var.destination-subnet-id
}
