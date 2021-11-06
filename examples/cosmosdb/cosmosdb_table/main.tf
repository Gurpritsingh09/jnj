
locals {
  pe_resource_group_name = "NA-DS-NPD-NWK-SH"
  pe_vnet                = "DS-NPD-VNET"
  pe_subnet              = "PVT"


  tags = {
    environment = "terraform-test"
    owner       = "Infra team"
    created-by  = "vdubey3"
  }

}


#resource "azurerm_resource_group" "cosmos-rg" {
#  name = "NA-DS-NPD-COS-SBX"
#  location="northeurope"
#}


module "cosmosdb_table" {

  source                    = "../../../modules/cosmosdb/cosmosdb_table/"
  cosmosdb_account_name     = "dsnpdcossbx-test"
  cosmosdb_keyspace_name    = "sbxkeyspace"
  cosmos_table_name         = "sbxtable"
  cosmosdb_table_threshold  = 400
  cosmos_resource_group     = "NA-DS-NPD-COS-SBX"
  cosmosdb_account_location = "North Europe"
  #supported_vnet
  #tags = local.tags  # Tags are NOT supported here

}

