# Storage Account
resource_group_name    = "EUN-DS-QA-STG-DATA"
pe_resource_group_name = "EUN-DS-QA-NWK-SH"
sa_vn_name             = "DS-QA-VNET"
restrict_public_access = false
storage_accounts = {
  sa1 = {
    name                    = "eundsqastgdata"
    sku                     = "Standard_GRS"
    account_kind            = null
    access_tier             = null
    assign_identity         = true # set this as true to assign MSI to storage account
    cmk_enable              = true #set this as true to enable encryption of storage account using customer managed key
    network_rules           = null
    enable_large_file_share = false
  }
}

tags = {
  source       = "terraform"
  environment  = "qa"
  application  = "DS"
  service      = "Storage Account"
  context      = ""
  owner        = "Infra Team"
  created-by   = "Terraform Provisioned"
  subscription = "DSP Sub - QA"
}

# Private Endpoint

private_endpoints = {
  pe1 = {
    resource_name            = "sa1"
    name                     = "eundsqastgdata-pe"
    approval_required        = false
    approval_message         = null
    group_ids                = ["blob"]
    dns_zone_name            = "privatelink.blob.core.windows.net"
    zone_exists              = false
    zone_to_vnet_link_exists = false
    registration_enabled     = false
    dns_a_records = [{
      name                  = "eundsqastgdata"
      ttl                   = 300
      ip_addresses          = null
      private_endpoint_name = null
    }]
  },
  pe2 = {
    resource_name            = "sa1"
    name                     = "eundsqastgdatafs-pe"
    approval_required        = false
    approval_message         = null
    group_ids                = ["file"]
    dns_zone_name            = "privatelink.file.core.windows.net"
    zone_exists              = false
    zone_to_vnet_link_exists = false
    registration_enabled     = false
    dns_a_records = [{
      name                  = "eundsqastgdata"
      ttl                   = 300
      ip_addresses          = null
      private_endpoint_name = null
    }]
  }
}

