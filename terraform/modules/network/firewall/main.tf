locals {
  region             = var.region
  tags               = var.tags
  rg_name            = var.rg_name
  afw_name           = var.afw_name
  sku_name           = var.sku_name
  sku_tier           = var.sku_tier
  firewall_policy_id = var.firewall_policy_id
  snet_id            = var.snet_id
  management_snet_id = var.management_snet_id
  pip_id             = var.pip_id
}

resource "azurerm_firewall" "afw" {
  location            = local.region
  tags                = local.tags
  resource_group_name = local.rg_name
  name                = local.afw_name
  sku_name            = local.sku_name
  sku_tier            = local.sku_tier
  firewall_policy_id  = local.firewall_policy_id

  ip_configuration {
    name      = "configuration"
    subnet_id = local.snet_id
  }

  management_ip_configuration {
    name                 = "management"
    subnet_id            = local.management_snet_id
    public_ip_address_id = local.pip_id
  }
}