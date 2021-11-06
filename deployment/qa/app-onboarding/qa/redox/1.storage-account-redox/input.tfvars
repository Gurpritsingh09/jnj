# Storage Account
resource_group_name    = "EUN-DS-QA-STG-REDOX"
pe_resource_group_name = "EUN-DS-QA-NWK-SH"
sa_vn_name             = "DS-QA-VNET"
specific_subnets       = []
restrict_public_access = false

storage_accounts = {
  sa1 = {
    name                    = "eundsqastgredox"
    sku                     = "Standard_GRS"
    account_kind            = null
    access_tier             = null
    assign_identity         = true # set this as true to assign MSI to storage account
    cmk_enable              = true # set this as true to enable encryption of storage account using customer managed key
    network_rules           = null
    enable_large_file_share = false
  }
}

containers = {
  c1 = {
    name                  = "from-redox"
    storage_account_name  = "eundsqastgredox"
    container_access_type = "private"
  }
}

tags = {
  source       = "terraform"
  environment  = "qa"
  service      = "Storage Account"
  context      = "StorageAccount"
  owner        = "Infra Team"
  created-by   = "Terraform Provisioned"
  team         = "HSDI"
  application  = "Redox"
  dsep_version = "2.0"
}

# Private Endpoint

private_endpoints = {
  pe1 = {
    resource_name            = "sa1"
    name                     = "eundsqastgredox-pe"
    approval_required        = false
    approval_message         = null
    group_ids                = ["blob"]
    dns_zone_name            = "privatelink.blob.core.windows.net"
    zone_exists              = true
    zone_to_vnet_link_exists = true
    registration_enabled     = true
    dns_a_records = [{
      name                  = "eundsqastgredox"
      ttl                   = 300
      ip_addresses          = null
      private_endpoint_name = null
    }]
  },
  pe2 = {
    resource_name            = "sa1"
    name                     = "eundsqastgredoxfs-pe"
    approval_required        = false
    approval_message         = null
    group_ids                = ["file"]
    dns_zone_name            = "privatelink.file.core.windows.net"
    zone_exists              = true
    zone_to_vnet_link_exists = true
    registration_enabled     = true
    dns_a_records = [{
      name                  = "eundsqastgredox"
      ttl                   = 300
      ip_addresses          = null
      private_endpoint_name = null
    }]
  }
}

### additional data lookup variables
keyvault_name           = "EUN-DS-QA-VLT"
keyvault_resource_group = "EUN-DS-QA-KEY-SH"
