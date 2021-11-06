data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

locals {
  tags = merge(var.tags, data.azurerm_resource_group.this.tags)
}

# Private Endpoint

resource "azurerm_private_endpoint" "this" {
  for_each            = var.private_endpoints
  name                = each.value["name"]
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  subnet_id           = var.subnet_ids

  private_service_connection {
    name                           = "${each.value["name"]}-connection"
    private_connection_resource_id = var.resource_ids != null ? lookup(var.resource_ids, lookup(each.value, "resource_name", null), null) : null
    is_manual_connection           = coalesce(lookup(each.value, "approval_required"), false)
    subresource_names              = lookup(each.value, "group_ids", null) == null ? null : lookup(each.value, "group_ids", null)
    request_message                = coalesce(lookup(each.value, "approval_required"), false) == true ? coalesce(lookup(each.value, "approval_message"), var.approval_message) : null
  }

  tags = local.tags
}

locals {
  private_dns_zones = {
    for pe_k, pe_v in var.private_endpoints : pe_k => {
      dns_zone_name            = pe_v.dns_zone_name
      zone_exists              = coalesce(pe_v.zone_exists, false)
      zone_to_vnet_link_exists = coalesce(pe_v.zone_to_vnet_link_exists, false)
      registration_enabled     = pe_v.registration_enabled
    }
  }


  dns_a_records_list = flatten([
    for pe_k, pe_v in azurerm_private_endpoint.this : [
      lookup(pe_v, "custom_dns_configs", null) == null ? [for arecord in coalesce(pe_v.private_service_connection, []) :
        {
          key                   = "${pe_k}_${var.private_endpoints[pe_k].dns_a_records[0].name}"
          a_record_name         = var.private_endpoints[pe_k].dns_a_records[0].name
          dns_zone_name         = var.private_endpoints[pe_k].dns_zone_name
          ttl                   = 300
          ip_addresses          = [arecord.private_ip_address]
          private_endpoint_name = pe_v.name
        }] : [for arecord in coalesce(pe_v.custom_dns_configs, []) :
        {
          key                   = "${pe_k}_${replace("${arecord.fqdn}", "${trimprefix(var.private_endpoints[pe_k].dns_zone_name, "privatelink")}", "")}"
          a_record_name         = replace("${arecord.fqdn}", "${trimprefix(var.private_endpoints[pe_k].dns_zone_name, "privatelink")}", "")
          dns_zone_name         = var.private_endpoints[pe_k].dns_zone_name
          ttl                   = 300
          ip_addresses          = [arecord.ip_addresses[0]]
          private_endpoint_name = replace("${arecord.fqdn}", "${trimprefix(var.private_endpoints[pe_k].dns_zone_name, "privatelink")}", "")
      }]
    ]
  ])

  pe_nicip_addresses = {
    for arecord in local.dns_a_records_list :
    arecord.private_endpoint_name => arecord.ip_addresses
  }

  dns_a_records = {
    for arecord in local.dns_a_records_list :
    arecord.key => arecord
  }
}

# Private DNS Zone

module "PrivateDNSZone" {
  source              = "../PrivateDNSZone"
  private_dns_zones   = local.private_dns_zones
  resource_group_name = data.azurerm_resource_group.this.name
  vnet_ids            = var.vnet_ids
  tags                = var.tags
}

# DNS A Record

module "PrivateDNSARecord" {
  source                        = "../PrivateDNSARecord"
  dns_a_records                 = local.dns_a_records
  resource_group_name           = data.azurerm_resource_group.this.name
  private_endpoint_ip_addresses = local.pe_nicip_addresses
  depends_on                    = [azurerm_private_endpoint.this, module.PrivateDNSZone]
}
