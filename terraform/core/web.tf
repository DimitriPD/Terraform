locals {
  # App Service Plan configuration
  asp_name = "asp-service-${local.env}"
  os_type  = "Linux"
  sku_name = "B1"

  # Function App configuration
  func_name = "func-service-${local.env}"
}

module "asp_service" {
  source = "../modules/web/service_plan"

  region   = local.region
  tags     = local.tags
  rg_name  = local.rg_services_name
  asp_name = local.asp_name
  os_type  = local.os_type
  sku_name = local.sku_name

  depends_on = [module.rg_services]
}

module "func_service" {
  source = "../modules/web/function_app"

  region                    = local.region
  tags                      = local.tags
  rg_name                   = local.rg_services_name
  func_name                 = local.func_name
  st_name                   = module.st_services.name
  st_primary_access_key     = module.st_services.primary_access_key
  asp_id                    = module.asp_service.id
  virtual_network_subnet_id = module.snet_infra["snet_C"].id

  depends_on = [
    module.rg_services,
    module.st_services,
    module.asp_service,
    module.snet_infra
  ]
}