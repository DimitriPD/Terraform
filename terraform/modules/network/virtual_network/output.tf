output "id" {
  value = azurerm_virtual_network.vnet.id
}

output "name" {
  value = azurerm_virtual_network.vnet.name
}

output "subnet" {
  value = azurerm_virtual_network.vnet.subnet
}

output "ip_address_pool" {
  value = azurerm_virtual_network.vnet.ip_address_pool
}