locals {
  # Virtual Network
  vnet_name = "vnet-infra-${local.env}"

  # Subnet
  snet_list = {
    snet_firewall_management = {
      name             = "AzureFirewallManagementSubnet"
      address_prefixes = ["10.0.0.0/26"]
      delegations      = []
    },
    snet_firewall = {
      name             = "AzureFirewallSubnet"
      address_prefixes = ["10.0.0.128/26"]
      delegations      = []
    },
    snet_A = {
      name             = "snet-A-${local.env}"
      address_prefixes = ["10.0.1.0/24"]
      delegations      = []
    },
    snet_B = {
      name             = "snet-B-${local.env}"
      address_prefixes = ["10.0.2.0/24"]
      delegations      = []
    },
    snet_C = {
      name             = "snet-C-${local.env}"
      address_prefixes = ["10.0.3.0/24"]
      delegations      = []
    },
    snet_C_Delegated = {
      name             = "snet-C-Delegated-${local.env}"
      address_prefixes = ["10.0.4.0/24"]
      delegations = [
        {
          name                    = "web"
          service_delegation_name = "Microsoft.Web/serverFarms"
          actions                 = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        }
      ]
    }

  }

  # Public IP
  pip_name              = "pip-infra-${local.env}"
  pip_allocation_method = "Static"
  pip_sku               = "Standard"

  # Azurerm Firewall Policy
  afwp_name = "afwp-infra-${local.env}"
  afwp_sku  = "Basic"

  # Azure Firewall
  afw_name               = "afw-infra-${local.env}"
  afw_sku_name           = "AZFW_VNet"
  afw_sku_tier           = "Basic"
  afw_firewall_policy_id = module.afwp_infra.id
  afw_snet_id            = module.snet_infra["snet_firewall"].id
  afw_management_snet_id = module.snet_infra["snet_firewall_management"].id

  # Azure Firewall Rule Collection Group
  afw_rcg_firewall_policy_id = module.afwp_infra.id
  afw_rcg_list = {
    net_rcg = {
      name     = "DefaultNetworkRuleCollectionGroup"
      priority = 100
      collections = [
        {
          name     = "Allow-Protocols-${local.env}"
          priority = 100
          action   = "Allow"
          rules = [
            {
              name                  = "Allow-ICMP-Snet-A-to-Snet-B"
              source_addresses      = [module.snet_infra["snet_A"].address_prefixes[0]]
              destination_ports     = ["*"]
              destination_addresses = [module.snet_infra["snet_B"].address_prefixes[0]]
              protocols             = ["ICMP"]
            },
            {
              name                  = "Allow-ICMP-Snet-B-to-Snet-A"
              source_addresses      = [module.snet_infra["snet_B"].address_prefixes[0]]
              destination_ports     = ["*"]
              destination_addresses = [module.snet_infra["snet_A"].address_prefixes[0]]
              protocols             = ["ICMP"]
            },
            {
              name                  = "Allow-HTTPS-Snet-B-to-Function-PEP"
              source_addresses      = [module.snet_infra["snet_B"].address_prefixes[0]]
              destination_ports     = ["443"]
              destination_addresses = [module.pep_infra["pep_func"].private_endpoint_ip]
              protocols             = ["TCP"]
            }
          ]
        },
        {
          name     = "Deny-All-${local.env}"
          priority = 200
          action   = "Deny"
          rules = [
            {
              name                  = "Deny-All-Inbound"
              source_addresses      = ["*"]
              destination_ports     = ["*"]
              destination_addresses = ["*"]
              protocols             = ["Any"]
            },
            {
              name                  = "Deny-All-Outbound"
              source_addresses      = ["*"]
              destination_ports     = ["*"]
              destination_addresses = ["*"]
              protocols             = ["Any"]
            }
          ]
        }
      ]
    }
  }

  # Private Endpoint
  pep_list = {
    pep_func = {
      name    = "pep-func-${local.env}"
      snet_id = module.snet_infra["snet_C"].id
      private_service_connections = [
        {
          name                           = "private-endpoint-connection"
          private_connection_resource_id = module.func_service.id
          is_manual_connection           = false
          subresource_names              = ["sites"]
        }
      ]
    }
  }

  # Network Security Group
  nsg_list = {
    nsg_A = {
      name = "nsg-A-${local.env}"
      security_rules = [
        {
          name                       = "Allow-ICMP-Inbound"
          protocol                   = "Icmp"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = module.snet_infra["snet_B"].address_prefixes[0]
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          destination_address_prefix = module.snet_infra["snet_A"].address_prefixes[0]
        },
        {
          name                       = "Allow-ICMP-Outbound"
          protocol                   = "Icmp"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = module.snet_infra["snet_A"].address_prefixes[0]
          priority                   = 100
          direction                  = "Outbound"
          access                     = "Allow"
          destination_address_prefix = module.snet_infra["snet_B"].address_prefixes[0]
        },
        {
          name                       = "Deny-All-Inbound"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          priority                   = 200
          direction                  = "Inbound"
          access                     = "Deny"
          destination_address_prefix = "*"
        },
        {
          name                       = "Deny-All-Outbound"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          priority                   = 200
          direction                  = "Outbound"
          access                     = "Deny"
          destination_address_prefix = "*"
        }
      ]
    },
    nsg_B = {
      name = "nsg-B-${local.env}"
      security_rules = [
        {
          name                       = "Allow-ICMP-Inbound"
          protocol                   = "Icmp"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = module.snet_infra["snet_A"].address_prefixes[0]
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          destination_address_prefix = module.snet_infra["snet_B"].address_prefixes[0]
        },
        {
          name                       = "Allow-ICMP-Outbound"
          protocol                   = "Icmp"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = module.snet_infra["snet_B"].address_prefixes[0]
          priority                   = 100
          direction                  = "Outbound"
          access                     = "Allow"
          destination_address_prefix = module.snet_infra["snet_A"].address_prefixes[0]
        },
        {
          name                       = "Allow-HTTPS-to-Function"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = module.snet_infra["snet_B"].address_prefixes[0]
          priority                   = 110
          direction                  = "Outbound"
          access                     = "Allow"
          destination_address_prefix = module.pep_infra["pep_func"].private_endpoint_ip
        },
        {
          name                       = "Deny-All-Inbound"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          priority                   = 200
          direction                  = "Inbound"
          access                     = "Deny"
          destination_address_prefix = "*"
        },
        {
          name                       = "Deny-All-Outbound"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          priority                   = 200
          direction                  = "Outbound"
          access                     = "Deny"
          destination_address_prefix = "*"
        }
      ]
    },
    nsg_C = {
      name = "nsg-C-${local.env}"
      security_rules = [
        {
          name                       = "Allow-HTTPS-Inbound"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = module.snet_infra["snet_B"].address_prefixes[0]
          priority                   = 110
          direction                  = "Inbound"
          access                     = "Allow"
          destination_address_prefix = module.pep_infra["pep_func"].private_endpoint_ip
        },
        {
          name                       = "Deny-All-Inbound"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          priority                   = 200
          direction                  = "Inbound"
          access                     = "Deny"
          destination_address_prefix = "*"
        },
        {
          name                       = "Deny-All-Outbound"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          priority                   = 200
          direction                  = "Outbound"
          access                     = "Deny"
          destination_address_prefix = "*"
        }
      ]
    },
    nsg_C_Delegated = {
      name = "nsg-C-Delegated-${local.env}"
      security_rules = [
        {
          name                       = "Deny-All-Inbound"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          priority                   = 300
          direction                  = "Inbound"
          access                     = "Deny"
          destination_address_prefix = "*"
        },
        {
          name                       = "Deny-All-Outbound"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          priority                   = 300
          direction                  = "Outbound"
          access                     = "Deny"
          destination_address_prefix = "*"
        }
      ]
    }
  }

  # Subnet Network Security Group Association
  snet_nsg_assoc_list = {
    snet_A = "nsg_A"
    snet_B = "nsg_B"
    snet_C = "nsg_C"
    snet_C_Delegated = "nsg_C_Delegated"
  }

  # Route Table
  rt_list = {
    rt_A = {
      name = "rt-A-${local.env}"
      routes = [
        {
          name                   = "udr-${module.snet_infra["snet_A"].name}"
          address_prefix         = module.snet_infra["snet_A"].address_prefixes[0]
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = module.afw_infra.private_firewall_ip
        }
      ]
    },
    rt_B = {
      name = "rt-B-${local.env}"
      routes = [
        {
          name                   = "udr-${module.snet_infra["snet_B"].name}"
          address_prefix         = module.snet_infra["snet_B"].address_prefixes[0]
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = module.afw_infra.private_firewall_ip
        },
        {
          name                   = "udr-to-function-pep"
          address_prefix         = "${module.pep_infra["pep_func"].private_endpoint_ip}/32"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = module.afw_infra.private_firewall_ip
        }
      ]
    },
    rt_C = {
      name = "rt-C-${local.env}"
      routes = [
        {
          name                   = "udr-${module.snet_infra["snet_C"].name}"
          address_prefix         = module.snet_infra["snet_C"].address_prefixes[0]
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = module.afw_infra.private_firewall_ip
        }
      ]
    },
    rt_C_Delegated = {
      name = "rt-C-Delegated-${local.env}"
      routes = [
        {
          name                   = "udr-${module.snet_infra["snet_C_Delegated"].name}"
          address_prefix         = module.snet_infra["snet_C_Delegated"].address_prefixes[0]
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = module.afw_infra.private_firewall_ip
        }
      ]
    }
  }

  # Subnet Route Table Association
  snet_rt_assoc_list = {
    snet_A = "rt_A"
    snet_B = "rt_B"
    snet_C = "rt_C"
    snet_C_Delegated = "rt_C_Delegated"
  }
}

module "vnet_infra" {
  source = "../modules/network/virtual_network"

  env       = local.env
  region    = local.region
  tags      = local.tags
  rg_name   = local.rg_infra_name
  vnet_name = local.vnet_name

  depends_on = [module.rg_infra]
}

module "snet_infra" {
  source = "../modules/network/subnet"

  for_each = local.snet_list

  env              = local.env
  region           = local.region
  tags             = local.tags
  rg_name          = local.rg_infra_name
  vnet_name        = local.vnet_name
  snet_name        = each.value.name
  address_prefixes = each.value.address_prefixes
  delegations      = each.value.delegations

  depends_on = [
    module.rg_infra,
    module.vnet_infra
  ]
}

module "pip_infra" {
  source = "../modules/network/public_ip"

  region            = local.region
  tags              = local.tags
  rg_name           = local.rg_infra_name
  pip_name          = local.pip_name
  allocation_method = local.pip_allocation_method
  sku               = local.pip_sku

  depends_on = [module.rg_infra]
}

module "afwp_infra" {
  source = "../modules/network/firewall_policy"

  region    = local.region
  tags      = local.tags
  rg_name   = local.rg_infra_name
  afwp_name = local.afwp_name
  sku       = local.afwp_sku

  depends_on = [
    module.rg_infra,
    module.snet_infra
  ]
}

module "afw_infra" {
  source = "../modules/network/firewall"

  region             = local.region
  tags               = local.tags
  rg_name            = local.rg_infra_name
  afw_name           = local.afw_name
  sku_name           = local.afw_sku_name
  sku_tier           = local.afw_sku_tier
  firewall_policy_id = local.afw_firewall_policy_id
  snet_id            = local.afw_snet_id
  management_snet_id = local.afw_management_snet_id
  pip_id             = module.pip_infra.id

  depends_on = [
    module.rg_infra,
    module.snet_infra,
    module.afwp_infra,
    module.pip_infra
  ]
}

module "afwp_rcg_infra" {
  source = "../modules/network/firewall_policy_rule_collection_group"

  for_each = local.afw_rcg_list

  firewall_policy_id = local.afw_rcg_firewall_policy_id
  afwp_rcg_name      = each.value.name
  priority           = each.value.priority
  collections        = each.value.collections

  depends_on = [module.afw_infra]
}

module "pep_infra" {
  source = "../modules/network/private_endpoint"

  for_each = local.pep_list

  env                         = local.env
  region                      = local.region
  tags                        = local.tags
  rg_name                     = local.rg_infra_name
  pep_name                    = each.value.name
  snet_id                     = each.value.snet_id
  private_service_connections = each.value.private_service_connections

  depends_on = [
    module.rg_infra,
    module.snet_infra,
    module.func_service
  ]
}

module "nsg_infra" {
  source = "../modules/network/network_security_group"

  for_each = local.nsg_list

  env            = local.env
  region         = local.region
  tags           = local.tags
  rg_name        = local.rg_infra_name
  nsg_name       = each.value.name
  security_rules = each.value.security_rules

  depends_on = [module.pep_infra]
}

module "snet_nsg_assoc" {
  source = "../modules/network/association/subnet_network_security_group_association"

  for_each = local.snet_nsg_assoc_list

  subnet_id = module.snet_infra[each.key].id
  nsg_id    = module.nsg_infra[each.value].id

  depends_on = [
    module.snet_infra,
    module.nsg_infra
  ]
}

module "rt_infra" {
  source = "../modules/network/route_table"

  for_each = local.rt_list

  env     = local.env
  region  = local.region
  tags    = local.tags
  rg_name = local.rg_infra_name
  rt_name = each.value.name
  routes  = each.value.routes

  depends_on = [module.afw_infra]
}

module "snet_rt_assoc" {
  source = "../modules/network/association/subnet_route_table_association"

  for_each = local.snet_rt_assoc_list

  snet_id = module.snet_infra[each.key].id
  rt_id   = module.rt_infra[each.value].id

  depends_on = [
    module.snet_infra,
    module.rt_infra
  ]
}