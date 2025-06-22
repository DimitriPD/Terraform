locals {
  region  = var.region
  tags    = var.tags
  rg_name = var.rg_name
}

resource "azurerm_resource_group" "rg" {
  location = local.region
  tags     = local.tags

  name = local.rg_name
}
