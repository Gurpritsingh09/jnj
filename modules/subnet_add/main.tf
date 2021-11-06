

resource "azurerm_subnet" "this" {
  for_each                                       = var.subnets
  name                                           = each.value["name"]
  resource_group_name                            = data.azurerm_resource_group.vnet.name
  address_prefixes                               = each.value["address_prefixes"]
  service_endpoints                              = length(each.value["service_endpoints"]) > 0 ? each.value["service_endpoints"] : null
  enforce_private_link_endpoint_network_policies = coalesce(lookup(each.value, "pe_enable"), false)
  enforce_private_link_service_network_policies  = coalesce(lookup(each.value, "pe_enable"), false)
  virtual_network_name                           = lookup(var.virtual_networks, each.value["vnet_key"], null)["name"]

  dynamic "delegation" {
    for_each = coalesce(lookup(each.value, "delegation"), [])
    content {
      name = lookup(delegation.value, "name", null)
      dynamic "service_delegation" {
        for_each = coalesce(lookup(delegation.value, "service_delegation"), [])
        content {
          name    = lookup(service_delegation.value, "name", null)
          actions = lookup(service_delegation.value, "actions", null)
        }
      }
    }
  }

  depends_on = [data.azurerm_virtual_network.vnet]
}

resource "azurerm_network_security_group" "this" {
  for_each            = var.network_security_groups
  name                = each.value["name"]
  location            = data.azurerm_resource_group.vnet.location
  resource_group_name = data.azurerm_resource_group.vnet.name

  dynamic "security_rule" {
    for_each = lookup(each.value, "security_rules", [])
    content {
      name                                       = security_rule.value["name"]
      description                                = lookup(security_rule.value, "description", null)
      protocol                                   = coalesce(security_rule.value["protocol"], "Tcp")
      direction                                  = security_rule.value["direction"]
      access                                     = coalesce(security_rule.value["access"], "Allow")
      priority                                   = security_rule.value["priority"]
      source_address_prefix                      = lookup(security_rule.value, "source_address_prefix", null)
      source_address_prefixes                    = lookup(security_rule.value, "source_address_prefixes", null)
      destination_address_prefix                 = lookup(security_rule.value, "destination_address_prefix", null)
      destination_address_prefixes               = lookup(security_rule.value, "destination_address_prefixes", null)
      source_port_range                          = lookup(security_rule.value, "source_port_range", null)
      source_port_ranges                         = lookup(security_rule.value, "source_port_ranges", null)
      destination_port_range                     = lookup(security_rule.value, "destination_port_range", null)
      destination_port_ranges                    = lookup(security_rule.value, "destination_port_ranges", null)
      source_application_security_group_ids      = lookup(security_rule.value, "source_application_security_group_names", null) != null ? [for asg_name in security_rule.value.source_application_security_group_names : lookup(var.app_security_group_ids_map, asg_name)] : null
      destination_application_security_group_ids = lookup(security_rule.value, "destination_application_security_group_names", null) != null ? [for asg_name in security_rule.value.destination_application_security_group_names : lookup(var.app_security_group_ids_map, asg_name)] : null
    }
  }
}

locals {
  subnet_names_network_security_group = [
    for x in var.subnets : "${x.vnet_key}_${x.name}" if lookup(x, "nsg_key", null) != null
  ]
  subnet_nsg_keys_network_security_group = [
    for x in var.subnets : {
      subnet_name = x.name
      nsg_key     = x.nsg_key
      vnet_key    = x.vnet_key
    } if lookup(x, "nsg_key", null) != null
  ]
  subnets_network_security_group = zipmap(local.subnet_names_network_security_group, local.subnet_nsg_keys_network_security_group)
}

# Associates a Network Security Group with a Subnet within a Virtual Network

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each                  = local.subnets_network_security_group
  network_security_group_id = lookup(azurerm_network_security_group.this, each.value["nsg_key"], null)["id"]
  subnet_id = [
    for x in azurerm_subnet.this : x.id if
    x.name == each.value["subnet_name"] &&
    x.virtual_network_name == "${lookup(var.virtual_networks, each.value["vnet_key"], null)["name"]}"
  ][0]
}

locals {
  subnet_names_with_route_table = [
    for x in var.subnets : "${x.vnet_key}_${x.name}" if lookup(x, "rt_key", null) != null
  ]
  subnet_rt_keys_with_route_table = [
    for x in var.subnets : {
      subnet_name = x.name
      rt_key      = x.rt_key
      vnet_key    = x.vnet_key
    } if lookup(x, "rt_key", null) != null
  ]
  subnets_with_route_table = zipmap(local.subnet_names_with_route_table, local.subnet_rt_keys_with_route_table)
}

# Associates a Route Table with a Subnet within a Virtual Network
resource "azurerm_subnet_route_table_association" "this" {
  for_each       = local.subnets_with_route_table
  route_table_id = lookup(data.azurerm_route_table.rt, each.value["rt_key"], null)["id"]
  subnet_id = [
    for x in azurerm_subnet.this : x.id if
    x.name == each.value["subnet_name"] &&
    x.virtual_network_name == "${lookup(var.virtual_networks, each.value["vnet_key"], null)["name"]}"
  ][0]
}
