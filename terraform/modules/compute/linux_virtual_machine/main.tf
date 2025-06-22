locals {
  region                = var.region
  tags                  = var.tags
  rg_name               = var.rg_name
  vm_name               = var.vm_name
  size                  = var.size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = var.network_interface_ids
  caching               = var.caching
  storage_account_type  = var.storage_account_type
}

resource "azurerm_linux_virtual_machine" "vm" {
  location                        = local.region
  tags                            = local.tags
  resource_group_name             = local.rg_name
  name                            = local.vm_name
  size                            = local.size
  admin_username                  = local.admin_username
  admin_password                  = local.admin_password
  disable_password_authentication = false

  network_interface_ids = local.network_interface_ids

  os_disk {
    caching              = local.caching
    storage_account_type = local.storage_account_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}