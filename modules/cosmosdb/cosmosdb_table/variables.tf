# Define variables required to create a Cassandra Table in an existing Keyspace

variable "cosmos_table_name" {
  type        = string
  description = "Specify table name to be created in supplied keyspace"
}

variable "cosmosdb_account_name" {
  type        = string
  description = "Specifiy the cosmosdb_account which will be parent to the keyspace"
}

variable "cosmosdb_keyspace_name" {
  type        = string
  description = "Specify Keyspace Name"
}

variable "cosmosdb_table_threshold" {
  type        = number
  description = "Specify Table Thereshold"
  default     = 400
}

variable "cosmos_resource_group" {
  description = "Resource Group"
  type        = string
  default     = ""
}

variable "cosmosdb_account_location" {
  description = "Azure Region (location) for Cosmos"
  type        = string
  default     = "northeurope"
}

