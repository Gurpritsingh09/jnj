# Storage Account
resource_group_name    = "EUN-DS-QA-STG-SH"
pe_resource_group_name = "EUN-DS-QA-NWK-SH"
sa_vn_name             = "DS-QA-VNET"
restrict_public_access = false
name                   = "eundsqastgsh"


tags = {
  environment  = "qa"
  application  = "DS"
  service      = "Storage Account"
  context      = "Diagnostics Logging"
  owner        = "Infra Team"
  created-by   = "Terraform Provisioned"
  subscription = "DSP Sub - QA"
}

# Private Endpoint

private_endpoints = {
  pe1 = {
    resource_name            = "sa1"
    name                     = "eundsqastgsh-pe"
    approval_required        = false
    approval_message         = null
    group_ids                = ["blob"]
    dns_zone_name            = "privatelink.blob.core.windows.net"
    zone_exists              = true
    zone_to_vnet_link_exists = true
    registration_enabled     = true
    dns_a_records = [{
      name                  = "eundsqastgsh"
      ttl                   = 300
      ip_addresses          = null
      private_endpoint_name = null
    }]
  },
  pe2 = {
    resource_name            = "sa1"
    name                     = "eundsqastgshfs-pe"
    approval_required        = false
    approval_message         = null
    group_ids                = ["file"]
    dns_zone_name            = "privatelink.file.core.windows.net"
    zone_exists              = true
    zone_to_vnet_link_exists = true
    registration_enabled     = true
    dns_a_records = [{
      name                  = "eundsqastgshfs"
      ttl                   = 300
      ip_addresses          = null
      private_endpoint_name = null
    }]
  }
}
