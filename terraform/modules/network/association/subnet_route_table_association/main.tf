locals {
  snet_id = var.snet_id
  rt_id   = var.rt_id
}

resource "azurerm_subnet_route_table_association" "assoc_rt_snet" {
  subnet_id      = local.snet_id
  route_table_id = local.rt_id
}