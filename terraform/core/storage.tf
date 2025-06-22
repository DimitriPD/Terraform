locals {
  st_name                  = "stservices${local.env}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

module "st_services" {
  source = "../modules/storage/storage_account"

  region                   = local.region
  tags                     = local.tags
  rg_name                  = local.rg_services_name
  st_name                  = local.st_name
  account_tier             = local.account_tier
  account_replication_type = local.account_replication_type

  depends_on = [module.rg_services]
}