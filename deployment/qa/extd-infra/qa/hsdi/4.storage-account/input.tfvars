# Storage Account
resource_group_name    = "EUN-DS-QA-STG-HSDI"
pe_resource_group_name = "EUN-DS-QA-NWK-SH"
sa_vn_name             = "DS-QA-VNET"
specific_subnets       = ["HSDI"]
restrict_public_access = false

storage_accounts = {
  sa1 = {
    name                    = "eundsqastghsdi01"
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
  c1 = {
    name                  = "redox-fhir-raw"
    storage_account_name  = "eundsqastghsdi01"
    container_access_type = "private"
  },
  c2 = {
    name                  = "redox-fhir-post"
    storage_account_name  = "eundsqastghsdi01"
    container_access_type = "private"
  },
  c3 = {
    name                  = "redox-fhir-response"
    storage_account_name  = "eundsqastghsdi01"
    container_access_type = "private"
  }
}

tags = {
  environment  = "QA"
  region       = "eun"
  owner        = "Infra Team"
  created-by   = "Terraform Provisioned"
  team         = "HSDI"
  application  = "Orthanc, Dicom"
  dsep_version = "2.0"
  subscription = "Digital Surgery Platform QA EUN"
}
# Private Endpoint

private_endpoints = {
  pe1 = {
    resource_name            = "sa1"
    name                     = "eundsqastghsdi01-pe"
    approval_required        = false
    approval_message         = null
    group_ids                = ["blob"]
    dns_zone_name            = "privatelink.blob.core.windows.net"
    zone_exists              = true
    zone_to_vnet_link_exists = true
    registration_enabled     = true
    dns_a_records = [{
      name                  = "eundsqastghsdi01"
      ttl                   = 300
      ip_addresses          = null
      private_endpoint_name = null
    }]
  },
  pe2 = {
    resource_name            = "sa1"
    name                     = "eundsqastghsdi01fs-pe"
    approval_required        = false
    approval_message         = null
    group_ids                = ["file"]
    dns_zone_name            = "privatelink.file.core.windows.net"
    zone_exists              = true
    zone_to_vnet_link_exists = true
    registration_enabled     = true
    dns_a_records = [{
      name                  = "eundsqastghsdi01"
      ttl                   = 300
      ip_addresses          = null
      private_endpoint_name = null
    }]
  }
}
