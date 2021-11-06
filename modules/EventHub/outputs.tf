output "namespace_id" {
  description = "Id of Event Hub Namespace."
  value       = azurerm_eventhub_namespace.this.id
}

output "hub_ids" {
  description = "Map of hubs and their ids."
  value       = { for k, v in azurerm_eventhub.this : k => v.id }
}

output "keys" {
  description = "Map of hubs with keys => primary_key / secondary_key mapping."
  sensitive   = true
  value = { for k, h in azurerm_eventhub_authorization_rule.this : h.name => {
    primary_key   = h.primary_key
    secondary_key = h.secondary_key
    }
  }
}

output "authorization_keys" {
  description = "Map of authorization keys with their ids."
  value       = { for a in azurerm_eventhub_namespace_authorization_rule.this : a.name => a.id }
}

output "eventhub_name" {
  description = "Name of the event hub namespace"
  value       = azurerm_eventhub_namespace.this.name
}
output "eventhub_sku" {
  description = "Sku of eventhub"
  value       = azurerm_eventhub_namespace.this.sku
}
output "eventhub_capacity" {
  description = "Eventhub capacity"
  value       = azurerm_eventhub_namespace.this.capacity
}
