locals {
  region            = var.region
  tags              = var.tags
  rg_name           = var.rg_name
  pip_name          = var.pip_name
  allocation_method = var.allocation_method
  sku               = var.sku
}

resource "azurerm_public_ip" "pip" {
  location            = local.region
  tags                = local.tags
  resource_group_name = local.rg_name
  name                = local.pip_name
  allocation_method   = local.allocation_method
  sku                 = local.sku
}