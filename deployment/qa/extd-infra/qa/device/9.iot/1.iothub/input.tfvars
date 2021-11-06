iot_hub_name                        = "eun-ds-qa-iot-dvc"
iot_resource_group_name             = "EUN-DS-QA-SVC-DVC"
iot_hub_storage_resource_group_name = "EUN-DS-QA-STG-DVC"
iot_hub_storage_account_name        = "eundsqastgdvc"
iot_location                        = "North Europe"
iot_hub_storage_container_name = "fromiothub"

iot_hub_sku = {
  iot_sku = {
    name     = "S2"
    capacity = 1
  }
}

iot_tags = {
  environment  = "QA"
  region       = "eun"
  owner        = "Infra Team"
  created-by   = "Terraform Provisioned"
  team         = "Device"
  application  = "Device"
  dsep_version = "2.0"
  subscription = "Digital Surgery Platform QA EUN"
}

endpoints = {
  endpoint1 = {
    endpoint-name                = "x509-credential-request"
    endpoint-route-name          = "x509-credential-request"
    endpoint-route-source        = "DeviceMessages"
    endpoint-route-condition     = "$body.type = 'x509-credential-request'"
    endpoint-route-enabled       = true
    eventhub-resource-group-name = "EUN-DS-QA-EVT-DVC"
    eventhub-namespace-name      = "eundsqaevtdvc"
    eventhub-eventhub-name       = "x509-certificate-provisioning"
    eventhub-auth-rule-name      = "x509-certificate-provisioning-ar"
  },
  endpoint2 = {
    endpoint-name                = "device-package-deployment-status"
    endpoint-route-name          = "device-package-deployment-status"
    endpoint-route-source        = "DeviceMessages"
    endpoint-route-condition     = "$body.type = 'package-deployment-status'"
    endpoint-route-enabled       = true
    eventhub-resource-group-name = "EUN-DS-QA-EVT-DVC"
    eventhub-namespace-name      = "eundsqaevtdvc"
    eventhub-eventhub-name       = "package-deployment-status"
    eventhub-auth-rule-name      = "package-deployment-status-ar"
  },
  endpoint3 = {
    endpoint-name                = "device-secrets"
    endpoint-route-name          = "device-secrets"
    endpoint-route-source        = "DeviceMessages"
    endpoint-route-condition     = "$body.type = 'device-secrets'"
    endpoint-route-enabled       = true
    eventhub-resource-group-name = "EUN-DS-QA-EVT-DVC"
    eventhub-namespace-name      = "eundsqaevtdvc"
    eventhub-eventhub-name       = "secrets-request"
    eventhub-auth-rule-name      = "secrets-request-ar"
  },
  endpoint4 = {
    endpoint-name                = "device-file-upload-notification"
    endpoint-route-name          = "device-file-upload-notification"
    endpoint-route-source        = "DeviceMessages"
    endpoint-route-condition     = "$body.type = 'file-upload'"
    endpoint-route-enabled       = true
    eventhub-resource-group-name = "EUN-DS-QA-EVT-DVC"
    eventhub-namespace-name      = "eundsqaevtdvc"
    eventhub-eventhub-name       = "file-upload-notification"
    eventhub-auth-rule-name      = "device-file-upload-notification-ar"
  }
}
