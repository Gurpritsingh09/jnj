
# Container Registry

resource_group_name            = "EUN-DS-QA-ACR-DVC"
pe_resource_group_name         = "EUN-DS-QA-NWK-SH"
acr_name                       = "eundsqaacrdvc"
diagnostics_storage_account    = "eundsqastgsh"
diagnostics_storage_account_rg = "EUN-DS-QA-STG-SH"

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

# Private Endpoint

private_endpoints = {
  pe1 = {
    resource_name            = "acr1"
    name                     = "eundsqaacrdvc-pe"
    approval_required        = false
    approval_message         = null
    group_ids                = ["registry"]
    dns_zone_name            = "privatelink.azurecr.io"
    zone_exists              = true
    zone_to_vnet_link_exists = true
    registration_enabled     = true
    dns_a_records = [{
      name                  = "eundsqaacrdvc"
      ttl                   = 300
      ip_addresses          = null
      private_endpoint_name = null
    }]
  }
}
