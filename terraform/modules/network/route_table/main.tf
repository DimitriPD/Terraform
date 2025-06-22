locals {
  location = var.region
  tags     = var.tags
  rg_name  = var.rg_name

  rt_name                       = var.rt_name
  bgp_route_propagation_enabled = var.bgp_route_propagation_enabled
  routes                        = var.routes
}

resource "azurerm_route_table" "rt" {
  location            = local.location
  tags                = local.tags
  resource_group_name = local.rg_name

  name                          = local.rt_name
  bgp_route_propagation_enabled = local.bgp_route_propagation_enabled

  dynamic "route" {
    for_each = local.routes
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_in_ip_address
    }
  }
}