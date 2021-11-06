iot_hub_name                        = "NA-DS-NPD-IOT-TEST-DEV"
iot_resource_group_name             = "NA-DS-NPD-IOT-DEV"
iot_hub_storage_resource_group_name = "NA-DS-NPD-STG-DEV"
iot_hub_storage_account_name        = "dsnpdstgdev"
iot_location                        = "North Europe"
iot_hub_storage_container_name      = "fromiothub"

iot_hub_sku = {
  iot_sku = {
    name     = "S2"
    capacity = 1
  }
}

iot_tags = {
  environment  = "dev"
  owner        = "Infra Team"
  created-by   = "Terraform Provisioned"
  team         = "Device"
  application  = "Device"
  dsep_version = "2.0"
}

endpoints = {
  endpoint1 = {
    endpoint-name                = "x509-credential-request"
    endpoint-route-name          = "x509-credential-request"
    endpoint-route-source        = "DeviceMessages"
    endpoint-route-condition     = "$body.msg_type='x509-credential-request'"
    endpoint-route-enabled       = true
    eventhub-resource-group-name = "NA-DS-NPD-EVT-DEV"
    eventhub-namespace-name      = "dspehubiot"
    eventhub-eventhub-name       = "x509-certificate-provisioning"
    eventhub-auth-rule-name      = "x509-certificate-provisioning-ar"
  },
  endpoint2 = {
    endpoint-name                = "device-package-deployment-status"
    endpoint-route-name          = "device-package-deployment-status"
    endpoint-route-source        = "DeviceMessages"
    endpoint-route-condition     = "$body.msg_type='device-package-deployment-status'"
    endpoint-route-enabled       = true
    eventhub-resource-group-name = "NA-DS-NPD-EVT-DEV"
    eventhub-namespace-name      = "dspehubiot"
    eventhub-eventhub-name       = "package-deployment-status"
    eventhub-auth-rule-name      = "package-deployment-status-ar"
  },
  endpoint3 = {
    endpoint-name                = "device-secrets"
    endpoint-route-name          = "device-secrets"
    endpoint-route-source        = "DeviceMessages"
    endpoint-route-condition     = "$body.msg_type='device-secrets'"
    endpoint-route-enabled       = true
    eventhub-resource-group-name = "NA-DS-NPD-EVT-DEV"
    eventhub-namespace-name      = "dspehubiot"
    eventhub-eventhub-name       = "secrets-request"
    eventhub-auth-rule-name      = "secrets-request-ar"
  }
}
