locals {
  region                   = var.region
  tags                     = var.tags
  rg_name                  = var.rg_name
  st_name                  = var.st_name
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_storage_account" "st" {
  location                 = local.region
  tags                     = local.tags
  resource_group_name      = local.rg_name
  name                     = local.st_name
  account_tier             = local.account_tier
  account_replication_type = local.account_replication_type
}