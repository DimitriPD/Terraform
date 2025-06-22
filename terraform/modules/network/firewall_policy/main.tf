locals {
  region    = var.region
  tags      = var.tags
  rg_name   = var.rg_name
  afwp_name = var.afwp_name
  sku       = var.sku
}

resource "azurerm_firewall_policy" "afwp" {
  location            = local.region
  tags                = local.tags
  resource_group_name = local.rg_name
  name                = local.afwp_name
  sku                 = local.sku
}