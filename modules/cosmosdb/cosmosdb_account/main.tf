# Create the COSMOS DB Account

resource "azurerm_cosmosdb_account" "cosmosdb_account" {
  name                = var.cosmosdb_account_name
  resource_group_name = var.cosmos_resource_group
  location            = var.cosmosdb_account_location
  offer_type          = var.cosmosdb_account_offer_type

  # Free Tier argument is NOT supported by Terraform
  #enable_free_tier    = var.free_tier

  #is_virtual_network_filter_enabled = true
  capabilities {
    name = var.capability_name
  }

#  capabilities {
#    name = "EnableTable"
#  }

  dynamic "consistency_policy" {
    for_each = var.consistency_policies
    content {
      consistency_level = consistency_policy.value.consistency_level 
      max_interval_in_seconds = consistency_policy.value.max_interval_in_seconds
      max_staleness_prefix = consistency_policy.value.max_staleness_prefix
    }
  }


  dynamic "virtual_network_rule" {
   for_each = var.virtual_network_rules
   content{
    id=virtual_network_rule.value
   }
  }

  dynamic "geo_location"{
   for_each = var.geo_locations
   content {
    location = geo_location.value.location
    failover_priority = geo_location.value.failover_priority
   }
  }
 tags = var.tags
}
