
resource_group_name = "EUN-DS-QA-NWK-SH"

# Virtual Network 

virtual_networks = {
  virtualnetwork1 = {
    name                 = "DS-QA-VNET"
    address_space        = ["10.190.0.0/16"]
    dns_servers          = null
    ddos_protection_plan = null
  },
  virtualnetwork2 = {
    name                 = "DS-QA-PRM-VNET"
    address_space        = ["172.27.0.0/16"]
    dns_servers          = null
    ddos_protection_plan = null
  }
}

# Subnets

subnets = {
  subnet1 = {
    vnet_key          = "virtualnetwork1"
    nsg_key           = "nsg1"
    rt_key            = "rt3"
    name              = "AGY"
    address_prefixes  = ["10.190.227.0/24"]
    service_endpoints = ["Microsoft.EventHub", "Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
    pe_enable         = true
    delegation        = []
  },
  subnet2 = {
    vnet_key          = "virtualnetwork1"
    nsg_key           = null
    rt_key            = "rt1"
    name              = "PVT"
    address_prefixes  = ["10.190.228.0/24"]
    service_endpoints = ["Microsoft.EventHub", "Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
    pe_enable         = true
    delegation        = []
  },
  subnet3 = {
    vnet_key          = "virtualnetwork1"
    nsg_key           = "nsg2"
    rt_key            = "rt1"
    name              = "DATA"
    address_prefixes  = ["10.190.32.0/20"]
    service_endpoints = ["Microsoft.EventHub", "Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
    pe_enable         = true
    delegation        = []
  },
  subnet4 = {
    vnet_key          = "virtualnetwork1"
    nsg_key           = "nsg3"
    rt_key            = "rt1"
    name              = "AKS"
    address_prefixes  = ["10.190.16.0/20"]
    service_endpoints = ["Microsoft.EventHub", "Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
    pe_enable         = true
    delegation        = []
  },
  subnet5 = {
    vnet_key          = "virtualnetwork1"
    nsg_key           = "nsg6"
    rt_key            = "rt1"
    name              = "VMS"
    address_prefixes  = ["10.190.229.0/24"]
    service_endpoints = ["Microsoft.EventHub", "Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
    pe_enable         = true
    delegation        = []
  },
  subnet6 = {
    vnet_key          = "virtualnetwork1"
    nsg_key           = "nsg4"
    rt_key            = "rt1"
    name              = "FHR"
    address_prefixes  = ["10.190.48.0/20"]
    service_endpoints = ["Microsoft.EventHub", "Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
    pe_enable         = true
    delegation        = []
  },
  subnet12 = {
    vnet_key          = "virtualnetwork2"
    nsg_key           = null
    rt_key            = null
    name              = "AzureFirewallSubnet"
    address_prefixes  = ["172.27.0.0/24"]
    service_endpoints = []
    pe_enable         = true
    delegation        = []
  },
  subnet13 = {
    vnet_key          = "virtualnetwork2"
    nsg_key           = null
    rt_key            = "rt2"
    name              = "GatewaySubnet"
    address_prefixes  = ["172.27.1.0/24"]
    service_endpoints = []
    pe_enable         = true
    delegation        = []
  },
  subnet14 = {
    vnet_key          = "virtualnetwork2"
    nsg_key           = "nsg5"
    rt_key            = "rt2"
    name              = "DNS"
    address_prefixes  = ["172.27.2.0/24"]
    service_endpoints = []
    pe_enable         = true
    delegation        = []
  }
}
# Network Security Groups

network_security_groups = {
  nsg1 = {
    name = "DS-QA-AGY-NSG"
    security_rules = [
      {
        name                                         = "APGW_Health_Probe"
        description                                  = "Ingress HTTP"
        priority                                     = 100
        direction                                    = "Inbound"
        access                                       = "Allow"
        protocol                                     = "Tcp"
        source_port_range                            = "*"
        source_port_ranges                           = null
        destination_port_range                       = "65200-65535"
        destination_port_ranges                      = []
        source_address_prefix                        = "*"
        source_address_prefixes                      = null
        destination_address_prefix                   = "*"
        destination_address_prefixes                 = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []
      },
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
    name = "DS-QA-DATA-NSG"
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
  nsg3 = {
    name = "DS-QA-AKS-NSG"
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
  nsg4 = {
    name = "DS-QA-FHR-NSG"
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
  nsg5 = {
    name = "binddns2-nsg"
    security_rules = [
      {
        name                                         = "SSH"
        description                                  = "Ingress HTTP"
        priority                                     = 300
        direction                                    = "Inbound"
        access                                       = "Allow"
        protocol                                     = "Tcp"
        source_port_range                            = "*"
        source_port_ranges                           = null
        destination_port_range                       = "22"
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
  nsg6 = {
    name = "DS-QA-VMS-NSG"
    security_rules = [
      {
        name                                         = "SSH_IB"
        description                                  = "Ingress ssh"
        priority                                     = 200
        direction                                    = "Inbound"
        access                                       = "Allow"
        protocol                                     = "Tcp"
        source_port_range                            = "*"
        source_port_ranges                           = null
        destination_port_range                       = "22"
        destination_port_ranges                      = []
        source_address_prefix                        = "*"
        source_address_prefixes                      = null
        destination_address_prefix                   = "*"
        destination_address_prefixes                 = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []
      },
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
    name                          = "DS-QA-ROUTE"
    disable_bgp_route_propagation = true
    routes = [
      {
        name                   = "Egress"
        address_prefix         = "0.0.0.0/0"
        next_hop_type          = "VirtualAppliance"
        next_hop_in_ip_address = "172.27.0.4"
      },
      {
        name                   = "VPN"
        address_prefix         = "10.223.0.0/16"
        next_hop_type          = "VirtualAppliance"
        next_hop_in_ip_address = "172.27.0.4"
      }
    ]
  },
  rt2 = {
    name                          = "DS-QA-VPN"
    disable_bgp_route_propagation = true
    routes = [
      {
        name                   = "VPN-Gateway"
        address_prefix         = "10.190.0.0/16"
        next_hop_type          = "VirtualAppliance"
        next_hop_in_ip_address = "172.27.0.4"
      }
    ]
  },
  rt3 = {
    name                          = "DS-QA-AGY"
    disable_bgp_route_propagation = true
    routes = [
      {
        name                   = "Egress"
        address_prefix         = "0.0.0.0/0"
        next_hop_type          = "Internet"
        next_hop_in_ip_address = null
      },
      {
        name                   = "VPN"
        address_prefix         = "10.223.0.0/16"
        next_hop_type          = "VirtualAppliance"
        next_hop_in_ip_address = "172.27.0.4"
      }
    ]
  }
}

diagnostics_storage_account = "eundsqastgsh"

diagnostics_storage_account_rg = "EUN-DS-QA-STG-SH"

tags = {
  source       = "terraform"
  environment  = "qa"
  application  = "DS"
  service      = "Networking"
  context      = "Network Stack"
  owner        = "Infra Team"
  created-by   = "Terraform Provisioned"
  subscription = "DSP Sub - QA"
}

