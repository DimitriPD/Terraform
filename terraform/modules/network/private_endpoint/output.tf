output "id" {
  value = azurerm_private_endpoint.pep.id
}

output "name" {
  value = azurerm_private_endpoint.pep.name
}

output "private_endpoint_ip" {
  value = azurerm_private_endpoint.pep.private_service_connection[0].private_ip_address
}