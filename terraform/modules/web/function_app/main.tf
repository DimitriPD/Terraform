locals {
  region  = var.region
  tags    = var.tags
  rg_name = var.rg_name

  func_name             = var.func_name
  st_name               = var.st_name
  st_primary_access_key = var.st_primary_access_key
  asp_id                = var.asp_id

  public_network_access_enabled = var.public_network_access_enabled
  virtual_network_subnet_id     = var.virtual_network_subnet_id
}

resource "azurerm_linux_function_app" "func" {
  location            = local.region
  tags                = local.tags
  resource_group_name = local.rg_name
  name                = local.func_name

  storage_account_name       = local.st_name
  storage_account_access_key = local.st_primary_access_key
  service_plan_id            = local.asp_id

  public_network_access_enabled = local.public_network_access_enabled
  virtual_network_subnet_id     = local.virtual_network_subnet_id

  site_config {
    application_stack {
      python_version = "3.10"
    }


  }
}