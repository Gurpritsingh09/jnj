data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

# Private Endpoint Connection

data "azurerm_private_endpoint_connection" "this" {
  for_each            = var.private_endpoints
  name                = each.value["name"]
  resource_group_name = data.azurerm_resource_group.this.name
  depends_on          = [azurerm_private_endpoint.this]
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

  pe_nicip_addresses = {
    for pe_k, pe_v in data.azurerm_private_endpoint_connection.this :
    pe_v.name => pe_v.private_service_connection.*.private_ip_address
  }
  dns_a_records_list = flatten([
    for pe_k, pe_v in var.private_endpoints : [
      for arecord in coalesce(pe_v.dns_a_records, []) :
      {
        key                   = "${pe_k}_${arecord.name}"
        a_record_name         = arecord.name
        dns_zone_name         = pe_v.dns_zone_name
        ttl                   = coalesce(arecord.ttl, 3600)
        ip_addresses          = arecord.ip_addresses
        private_endpoint_name = coalesce(arecord.private_endpoint_name, pe_v.name)
      } if(pe_v.dns_zone_name != null)
    ]
  ])
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
  a_records_depends_on          = module.PrivateDNSZone
}
