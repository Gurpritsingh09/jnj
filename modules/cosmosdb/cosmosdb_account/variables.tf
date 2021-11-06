# Declare all variables required for module

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


variable "cosmosdb_account_name" {
  description = "Name of Cosmos DB Account"
  type        = string
}


variable "cosmosdb_account_offer_type" {
  description = "Currently Terraform supports only Standard"
  type        = string
  default     = "Standard"
}

variable "cosmosdb_kind" {
  description = "Kind of CosmosDB to create - possible values are GlobalDocumentDB and MongoDB. Defaults to GlobalDocumentDB"
  type        = string
  default     = "GlobalDocumentDB"
}

variable "enable_automatic_failover" {
  type    = bool
  default = true
}


variable "supported_vnet" {
  description = "Virtual Network to allow traffic from into cosmosdb "
  type        = string
  default     = "DS-NPD-VNET"
}

variable "capability_name" {
  description = "The capabilities which should be enabled for this Cosmos DB account. Possible values are EnableAggregationPipeline, EnableCassandra, EnableGremlin, EnableTable, MongoDBv3.4, and mongoEnableDocLevelTTL"
  type        = string
  default     = "EnableCassandra"

}

variable "geo_locations" {
  description = "geographic locations the data is replicated to"
  type = list(object({
    prefix            = string #The string used to generate the document endpoints for this region. Defaults to ${cosmosdb_account.name}-${location}
    location          = string #The name of the Azure region to host replicated data.
    failover_priority = number #The failover priority of the region. A failover priority of 0 indicates a write region. max value=(total number of regions - 1)
  }))
}

variable "virtual_network_rules" {
  description = "Virtual Network Rules: allow traffic from selected SUBNETS"
  type        = list(string)
  default     = []
}

variable "failover_location" {
  default = "australiasoutheast"
}

variable "free_tier" {
  type    = bool
  default = false
}

variable "consistency_policies" {
  description = "block of consistency policies"
  type = list(object({
    consistency_level       = string #can be either BoundedStaleness, Eventual, Session, Strong or ConsistentPrefix
    max_interval_in_seconds = number
    max_staleness_prefix    = number
  }))

  default = [{ consistency_level = "Eventual", max_interval_in_seconds = 5, max_staleness_prefix = 100 }]

}


variable "tags" {
  type        = map(string)
  description = "Tags for cosmosdb account"
  default     = {}
}

