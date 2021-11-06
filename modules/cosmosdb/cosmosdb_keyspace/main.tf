# Create Cosmos Cassandra Keyspace Name 

resource "azurerm_cosmosdb_cassandra_keyspace" "cassandra_keyspace" {
  name                = var.cosmosdb_keyspace_name
  resource_group_name = var.cosmos_resource_group
  account_name        = var.cosmosdb_account_name
  throughput          = 400
  #tags                = var.tags
}
