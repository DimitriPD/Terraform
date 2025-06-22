locals {
  # Common
  env    = "dev"
  region = "swedencentral"
  tags = {
    environment = local.env
    created_by  = "terraform"
    managed_by  = "terraform"
  }

  # Resource Group
  rg_infra_name    = "rg-infra-${local.env}"
  rg_services_name = "rg-services-${local.env}"
}

module "rg_infra" {
  source = "../modules/common/resource_group"

  env     = local.env
  region  = local.region
  tags    = local.tags
  rg_name = local.rg_infra_name
}

module "rg_services" {
  source = "../modules/common/resource_group"

  env     = local.env
  region  = local.region
  tags    = local.tags
  rg_name = local.rg_services_name
}