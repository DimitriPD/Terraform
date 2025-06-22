output "id" {
  value = azurerm_firewall.afw.id
}

output "name" {
  value = azurerm_firewall.afw.name
}

output "private_firewall_ip" {
  value = azurerm_firewall.afw.ip_configuration[0].private_ip_address
}