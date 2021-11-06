# Storage Account
resource_group_name    = "EUN-DS-QA-STG-DVC"
pe_resource_group_name = "EUN-DS-QA-NWK-SH"
sa_vn_name             = "DS-QA-VNET"
specific_subnets       = ["DVC"]
restrict_public_access = false
storage_accounts = {
  sa1 = {
    name                    = "eundsqastgdvc"
    sku                     = "Standard_GRS"
    account_kind            = null
    access_tier             = null
    assign_identity         = true # set this as true to assign MSI to storage account
    cmk_enable              = true #set this as true to enable encryption of storage account using customer managed key
    network_rules           = null
    enable_large_file_share = false
  }
}

containers = {
  cont1 = {
    name                  = "iot-pkg-deploy-repo"
    storage_account_name  = "eundsqastgdvc"
    container_access_type = "private"
  },
  cont2 = {
    name                  = "iot-hub-backup-container"
    storage_account_name  = "eundsqastgdvc"
    container_access_type = "private"
  },
  cont3 = {
    name                  = "device-twin-snapshot-container"
    storage_account_name  = "eundsqastgdvc"
    container_access_type = "private"
  },
  cont4 = {
    name                  = "fromiothub"
    storage_account_name  = "eundsqastgdvc"
    container_access_type = "private"
  }
}

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
    resource_name            = "sa1"
    name                     = "eundsqastgdvc-pe"
    approval_required        = false
    approval_message         = null
    group_ids                = ["blob"]
    dns_zone_name            = "privatelink.blob.core.windows.net"
    zone_exists              = true
    zone_to_vnet_link_exists = true
    registration_enabled     = true
    dns_a_records = [{
      name                  = "eundsqastgdvc"
      ttl                   = 300
      ip_addresses          = null
      private_endpoint_name = null
    }]
  },
  pe2 = {
    resource_name            = "sa1"
    name                     = "eundsqastgdvcfs-pe"
    approval_required        = false
    approval_message         = null
    group_ids                = ["file"]
    dns_zone_name            = "privatelink.file.core.windows.net"
    zone_exists              = true
    zone_to_vnet_link_exists = true
    registration_enabled     = true
    dns_a_records = [{
      name                  = "eundsqastgdvc"
      ttl                   = 300
      ip_addresses          = null
      private_endpoint_name = null
    }]
  }
}
