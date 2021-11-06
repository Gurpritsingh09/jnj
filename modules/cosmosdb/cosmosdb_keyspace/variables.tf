# Define variables/inputs required for KeySpace creation

variable "cosmosdb_account_name" {
  type        = string
  description = "Specifiy the cosmosdb_account which will be parent to the keyspace"
}

variable "cosmosdb_keyspace_name" {
  type        = string
  description = "Specify Keyspace Name"
}

variable "cosmosdb_keyspace_threshold" {
  type        = number
  description = "Specify Keyspace Thereshold"
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

variable "tags" {
  type        = map(string)
  description = "Tags for cosmosdb keyspace"
  default     = {}
}

