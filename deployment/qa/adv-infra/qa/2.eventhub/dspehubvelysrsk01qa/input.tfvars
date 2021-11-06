resource_group_name    = "EUN-DS-QA-EVT-VELYSRSK"
pe_resource_group_name = "EUN-DS-QA-NWK-SH"
location               = "northeurope"
eventhub_name          = "EUNDSQAEVTVELYSRSK01"
restrict_public_access = false
eventhub_vn_name       = "DS-QA-VNET"
hubs                   = []
capacity               = 20
auto_inflate           = { enabled = true, maximum_throughput_units = 20 }


tags = {
  source       = "terraform"
  environment  = "qa"
  application  = "DS"
  service      = "EventHub"
  context      = "EventHub"
  owner        = "Infra Team"
  created-by   = "Terraform Provisioned"
  subscription = "DSP Sub - QA"
}

#  Private Endpoint

private_endpoints = {
  pe1 = {
    resource_name            = "eventhub"
    name                     = "eundsqaevtvelysrsk01-pe"
    approval_required        = false
    approval_message         = null
    group_ids                = ["namespace"]
    dns_zone_name            = "privatelink.servicebus.windows.net"
    zone_exists              = false
    zone_to_vnet_link_exists = false
    registration_enabled     = false
    dns_a_records = [{
      name                  = "eundsqaevtvelysrsk01"
      ttl                   = 300
      ip_addresses          = null
      private_endpoint_name = null
    }]
  }
}
