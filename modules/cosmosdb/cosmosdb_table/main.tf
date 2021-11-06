# Create Table

resource "azurerm_cosmosdb_table" "cosmosdb_table" {
  #name                = "${var.cosmosdb_keyspace_name}.${var.cosmos_table_name}"
  name                = var.cosmos_table_name
  resource_group_name = data.azurerm_cosmosdb_account.cosmosdb_account.resource_group_name
  account_name        = data.azurerm_cosmosdb_account.cosmosdb_account.name
  throughput          = var.cosmosdb_table_threshold
}
