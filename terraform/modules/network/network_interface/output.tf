output "id" {
  value = azurerm_network_interface.nic
}

output "name" {
  value = azurerm_network_interface.nic.name
}

output "private_interface_ip" {
  value = azurerm_network_interface.nic.ip_configuration[0].private_ip_address
}