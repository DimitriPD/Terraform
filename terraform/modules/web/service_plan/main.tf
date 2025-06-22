locals {
  region   = var.region
  tags     = var.tags
  rg_name  = var.rg_name
  asp_name = var.asp_name
  os_type  = var.os_type
  sku_name = var.sku_name
}

resource "azurerm_service_plan" "asp" {
  location            = local.region
  tags                = local.tags
  resource_group_name = local.rg_name
  name                = local.asp_name
  os_type             = local.os_type
  sku_name            = local.sku_name
}