locals {
  region    = var.region
  tags      = var.tags
  rg_name   = var.rg_name
  nic_name  = var.nic_name
  subnet_id = var.subnet_id
}

resource "azurerm_network_interface" "nic" {
  location            = local.region
  tags                = local.tags
  resource_group_name = local.rg_name
  name                = local.nic_name

  ip_configuration {
    name                          = "configuration"
    subnet_id                     = local.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}