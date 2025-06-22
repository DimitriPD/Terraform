locals {
  subnet_id = var.subnet_id
  nsg_id    = var.nsg_id
}

resource "azurerm_subnet_network_security_group_association" "assoc_nsg_snet" {
  subnet_id                 = local.subnet_id
  network_security_group_id = local.nsg_id
}
