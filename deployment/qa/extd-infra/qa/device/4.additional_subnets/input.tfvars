
resource_group_name = "EUN-DS-QA-NWK-SH"

# Virtual Network

virtual_networks = {
  virtualnetwork1 = {
    name = "DS-QA-VNET"
  }
}

# Subnets

subnets = {
  subnet1 = {
    vnet_key          = "virtualnetwork1"
    nsg_key           = "nsg1"
    rt_key            = "rt1"
    name              = "DVC"
    address_prefixes  = ["10.190.64.0/22"]
    service_endpoints = ["Microsoft.EventHub", "Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
    pe_enable         = true
    delegation        = []
  },
  subnet2 = {
    vnet_key          = "virtualnetwork1"
    nsg_key           = "nsg2"
    rt_key            = "rt1"
    name              = "DVC-AZF"
    address_prefixes  = ["10.190.72.0/26"]
    service_endpoints = ["Microsoft.EventHub", "Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
    pe_enable         = true
    delegation = [
      {
        name = "AzureFunction"
        service_delegation = [
          {
            name    = "Microsoft.Web/serverFarms"
            actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
          }
        ]
      }
    ]
  }
}
# Nework Security Groups

network_security_groups = {
  nsg1 = {
    name = "DS-QA-DVC-NSG"
    security_rules = [
      {
        name                                         = "HTTP_IB"
        description                                  = "Ingress HTTP"
        priority                                     = 201
        direction                                    = "Inbound"
        access                                       = "Allow"
        protocol                                     = "Tcp"
        source_port_range                            = "*"
        source_port_ranges                           = null
        destination_port_range                       = "80"
        destination_port_ranges                      = []
        source_address_prefix                        = "*"
        source_address_prefixes                      = null
        destination_address_prefix                   = "*"
        destination_address_prefixes                 = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []
      },
      {
        name                                         = "HTTPS_IB"
        description                                  = "Ingress HTTPS"
        priority                                     = 202
        direction                                    = "Inbound"
        access                                       = "Allow"
        protocol                                     = "Tcp"
        source_port_range                            = "*"
        source_port_ranges                           = null
        destination_port_range                       = "443"
        destination_port_ranges                      = []
        source_address_prefix                        = "*"
        source_address_prefixes                      = null
        destination_address_prefix                   = "*"
        destination_address_prefixes                 = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []
      }
    ]
  },
  nsg2 = {
    name = "DS-QA-DVC-AZF-NSG"
    security_rules = [
      {
        name                                         = "HTTP_IB"
        description                                  = "Ingress HTTP"
        priority                                     = 201
        direction                                    = "Inbound"
        access                                       = "Allow"
        protocol                                     = "Tcp"
        source_port_range                            = "*"
        source_port_ranges                           = null
        destination_port_range                       = "80"
        destination_port_ranges                      = []
        source_address_prefix                        = "*"
        source_address_prefixes                      = null
        destination_address_prefix                   = "*"
        destination_address_prefixes                 = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []
      },
      {
        name                                         = "HTTPS_IB"
        description                                  = "Ingress HTTPS"
        priority                                     = 202
        direction                                    = "Inbound"
        access                                       = "Allow"
        protocol                                     = "Tcp"
        source_port_range                            = "*"
        source_port_ranges                           = null
        destination_port_range                       = "443"
        destination_port_ranges                      = []
        source_address_prefix                        = "*"
        source_address_prefixes                      = null
        destination_address_prefix                   = "*"
        destination_address_prefixes                 = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []
      }
    ]
  }
}

# Routing Table

route_tables = {
  rt1 = {
    name = "DS-QA-ROUTE"
  }
}
