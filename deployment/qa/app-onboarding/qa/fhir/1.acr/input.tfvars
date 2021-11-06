
# Container Registry

resource_group_name            = "EUN-DS-QA-ACR-HSDI"
pe_resource_group_name         = "EUN-DS-QA-NWK-SH"
acr_name                       = "eundsqaacrhsdi"
diagnostics_storage_account    = "eundsqastgsh"
diagnostics_storage_account_rg = "EUN-DS-QA-STG-SH"
tags = {
  source       = "terraform"
  environment  = "qa"
  application  = "DS"
  service      = "Fhir Container Registry"
  context      = "Container Image Gallery"
  owner        = "Infra Team"
  created-by   = "Terraform Provisioned"
  subscription = "DSP Sub - QA"
}

# Private Endpoint

private_endpoints = {
  pe1 = {
    resource_name            = "acr1"
    name                     = "eundsqaacrhsdi-pe"
    approval_required        = false
    approval_message         = null
    group_ids                = ["registry"]
    dns_zone_name            = "privatelink.azurecr.io"
    zone_exists              = true
    zone_to_vnet_link_exists = true
    registration_enabled     = true
    dns_a_records = [{
      name                  = "eundsqaacrhsdi"
      ttl                   = 300
      ip_addresses          = null
      private_endpoint_name = null
    }]
  }
}
