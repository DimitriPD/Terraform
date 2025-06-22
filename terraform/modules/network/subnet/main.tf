locals {
  rg_name   = var.rg_name
  vnet_name = var.vnet_name

  snet_name                         = var.snet_name
  address_prefixes                  = var.address_prefixes
  private_endpoint_network_policies = var.private_endpoint_network_policies

}

resource "azurerm_subnet" "snet" {
  resource_group_name  = local.rg_name
  virtual_network_name = local.vnet_name

  name                              = local.snet_name
  address_prefixes                  = local.address_prefixes
  private_endpoint_network_policies = local.private_endpoint_network_policies
}