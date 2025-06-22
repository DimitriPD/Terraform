locals {
  region  = var.region
  tags    = var.tags
  rg_name = var.rg_name

  pep_name                    = var.pep_name
  snet_id                     = var.snet_id
  private_service_connections = var.private_service_connections
}

resource "azurerm_private_endpoint" "pep" {
  location            = local.region
  tags                = local.tags
  resource_group_name = local.rg_name

  subnet_id = local.snet_id
  name      = local.pep_name

  dynamic "private_service_connection" {
    for_each = local.private_service_connections
    content {
      name                           = private_service_connection.value.name
      private_connection_resource_id = private_service_connection.value.private_connection_resource_id
      is_manual_connection           = private_service_connection.value.is_manual_connection
      subresource_names              = private_service_connection.value.subresource_names
    }
  }
}