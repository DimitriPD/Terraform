locals {
  env     = var.env
  region  = var.region
  tags    = var.tags
  rg_name = var.rg_name

  vnet_name                      = var.vnet_name
  address_space                  = var.address_space
  private_endpoint_vnet_policies = var.private_endpoint_vnet_policies
}

resource "azurerm_virtual_network" "vnet" {
  location            = local.region
  tags                = local.tags
  resource_group_name = local.rg_name

  name                           = local.vnet_name
  address_space                  = local.address_space
  private_endpoint_vnet_policies = local.private_endpoint_vnet_policies
}