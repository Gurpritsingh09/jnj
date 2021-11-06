# Key Vault 

resource_group_name             = "EUN-DS-QA-KEY-HSDI"
pe_resource_group_name          = "EUN-DS-QA-NWK-SH"
keyvault_name                   = "EUN-DS-QA-VLT-HSDI"
sku_name                        = "standard"
enabled_for_deployment          = true
enabled_for_disk_encryption     = true
enabled_for_template_deployment = true
soft_delete_enabled             = true
purge_protection_enabled        = true
diagnostics_storage_account     = "eundsqastgsh"
diagnostics_storage_account_rg  = "EUN-DS-QA-STG-SH"
tags = {
  source       = "terraform"
  environment  = "qa"
  application  = "DS"
  service      = "Keyvault"
  context      = "Secret Store"
  owner        = "Infra Team"
  created-by   = "Terraform Provisioned"
  subscription = "DSP Sub - QA"
}

# Private Endpoint

private_endpoints = {
  pe1 = {
    resource_name            = "keyvault"
    name                     = "eun-ds-qa-vlt-hsdi-pe"
    approval_required        = false
    approval_message         = null
    group_ids                = ["vault"]
    dns_zone_name            = "privatelink.vaultcore.azure.net"
    zone_exists              = true
    zone_to_vnet_link_exists = true
    registration_enabled     = true
    dns_a_records = [{
      name                  = "eun-ds-qa-vlt-hsdi"
      ttl                   = 300
      ip_addresses          = null
      private_endpoint_name = null
    }]
  }
}
