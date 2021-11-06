
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


module "cosmosdb_keyspace" {

  source                      = "../../../modules/cosmosdb/cosmosdb_keyspace/"
  cosmosdb_account_name       = "dsnpdcossbx-example"
  cosmosdb_keyspace_name      = "sbxkeyspace-example"
  cosmosdb_keyspace_threshold = 400
  cosmos_resource_group       = "NA-DS-NPD-COS-SBX-example"
  cosmosdb_account_location   = "North Europe"
  #supported_vnet
  #tags = local.tags  # Tags are NOT supported here

}

