locals {
  resource_ids = {
    dsnpdcossbx01-example = module.cosmosdb_storage_account.id
  }
  pe_resource_group_name = "NA-DS-NPD-NWK-SH"
  pe_vnet                = "DS-NPD-VNET"
  pe_subnet              = "PVT"


  geo_locations = [
    {
      prefix            = "dsnpdcossbx-example-northeurope"
      location          = "northeurope"
      failover_priority = 0
    }

  ]

  private_endpoints = {
    pe1 = {
      resource_name            = "dsnpdcossbx01-example"
      name                     = "dsnpdcossbx-example-pe"
      approval_required        = false
      approval_message         = null
      group_ids                = ["Cassandra"]
      dns_zone_name            = "privatelink.documents.azure.com"
      zone_exists              = false
      zone_to_vnet_link_exists = false
      registration_enabled     = false
      dns_a_records = [{
        name                  = "dsnpdcossbx-example"
        ttl                   = 300
        ip_addresses          = null
        private_endpoint_name = null
      }]
    }
  }
  tags = {
    environment = "terraform-test"
    owner       = "Infra team"
    created-by  = "vdubey3"
  }

}


resource "azurerm_resource_group" "cosmos-rg" {
  name     = "NA-DS-NPD-COS-SBX-example"
  location = "northeurope"
}

data "azurerm_virtual_network" "pe_allowed_vnet" {
  name                = local.pe_vnet
  resource_group_name = local.pe_resource_group_name
}

data "azurerm_subnet" "pe_allowed_subnet" {
  name                 = local.pe_subnet
  virtual_network_name = local.pe_vnet
  resource_group_name  = local.pe_resource_group_name
}

module "cosmosdb_storage_account" {

  source                = "../../../modules/cosmosdb/cosmosdb_account/"
  cosmosdb_account_name = "dsnpdcossbx-example"

  free_tier                   = true
  cosmos_resource_group       = "NA-DS-NPD-COS-SBX-example"
  cosmosdb_account_location   = "North Europe"
  cosmosdb_account_offer_type = "Standard"
  cosmosdb_kind               = "GlobalDocumentDB"
  enable_automatic_failover   = false
  #supported_vnet
  capability_name = "EnableCassandra"
  #virtual_network_rules=[data.azurerm_subnet.pe_allowed_subnet.id]
  #virtual_network_rules=[]
  geo_locations        = local.geo_locations
  consistency_policies = [{ consistency_level = "Eventual", max_interval_in_seconds = 5, max_staleness_prefix = 100 }]

  tags = local.tags

  depends_on = [azurerm_resource_group.cosmos-rg]
}

module "PrivateEndpoint" {
  source              = "../../../modules/PrivateEndpoint"
  private_endpoints   = local.private_endpoints
  resource_group_name = local.pe_resource_group_name
  subnet_ids          = data.azurerm_subnet.pe_allowed_subnet.id        # PVT subnet
  vnet_ids            = data.azurerm_virtual_network.pe_allowed_vnet.id # "name": "DS-NPD-VNET","resource_group_name": "NA-DS-NPD-NWK-SH"
  resource_ids        = local.resource_ids
  tags                = local.tags

  #depends_on = [module.cosmosdb_storage_account]
}

