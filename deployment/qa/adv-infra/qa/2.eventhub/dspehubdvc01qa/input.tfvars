resource_group_name    = "EUN-DS-QA-EVT-DVC"
pe_resource_group_name = "EUN-DS-QA-NWK-SH"
location               = "northeurope"
eventhub_name          = "EUNDSQAEVTDVC"
restrict_public_access = false
eventhub_vn_name       = "DS-QA-VNET"

hubs = [
  {
    name              = "x509-certificate-provisioning",
    partitions        = 2,
    message_retention = 1,
    consumers         = [],
    keys = [
      {
        name   = "x509-certificate-provisioning-ar",
        listen = true,
        send   = true
      }
    ]
  },
  {
    name              = "package-deployment-status",
    partitions        = 2,
    message_retention = 1,
    consumers         = [],
    keys = [
      {
        name   = "package-deployment-status-ar",
        listen = true,
        send   = true
      }
    ]
  },
  {
    name              = "secrets-request",
    partitions        = 2,
    message_retention = 1,
    consumers         = [],
    keys = [
      {
        name   = "secrets-request-ar",
        listen = true,
        send   = true
      }
    ]
  },
  {
    name              = "file-upload-notification",
    partitions        = 2,
    message_retention = 1,
    consumers         = [],
    keys = [
      {
        name   = "device-file-upload-notification-ar",
        listen = true,
        send   = true
      }
    ]
  }
]

capacity     = 2
auto_inflate = { enabled = true, maximum_throughput_units = 20 }

tags = {
  environment  = "QA"
  region       = "eun"
  owner        = "Infra Team"
  created-by   = "Terraform Provisioned"
  team         = "Device"
  application  = "Device"
  dsep_version = "2.0"
  subscription = "Digital Surgery Platform QA EUN"
}

#  Private Endpoint

private_endpoints = {
  pe1 = {
    resource_name            = "eventhub"
    name                     = "eundsqaevtdvc-pe"
    approval_required        = false
    approval_message         = null
    group_ids                = ["namespace"]
    dns_zone_name            = "privatelink.servicebus.windows.net"
    zone_exists              = true
    zone_to_vnet_link_exists = true
    registration_enabled     = true
    dns_a_records = [{
      name                  = "eundsqaevtdvc"
      ttl                   = 300
      ip_addresses          = null
      private_endpoint_name = null
    }]
  }
}
