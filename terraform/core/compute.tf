locals {
  # Linux Virtual Machines
  vm_linux_map = {
    "vm_A" = {
      vm_name               = "vm-A-${local.env}"
      size                  = "Standard_B1s"
      admin_username        = "adminuser_A"
      admin_password        = var.admin_password_VM_A
      network_interface_ids = [module.nic_infra["nic_VM_A"].id]
      caching               = "ReadWrite"
      storage_account_type  = "Standard_LRS"
    },
    "vm_B" = {
      vm_name               = "vm-B-${local.env}"
      size                  = "Standard_B1s"
      admin_username        = "adminuser_B"
      admin_password        = var.admin_password_VM_B
      network_interface_ids = [module.nic_infra["nic_VM_B"].id]
      caching               = "ReadWrite"
      storage_account_type  = "Standard_LRS"
    }
  }
}

module "vm_service" {
  source = "../modules/compute/linux_virtual_machine"

  for_each = local.vm_linux_map

  region                = local.region
  tags                  = local.tags
  rg_name               = local.rg_services_name
  vm_name               = each.value.vm_name
  size                  = each.value.size
  admin_username        = each.value.admin_username
  admin_password        = each.value.admin_password
  network_interface_ids = each.value.network_interface_ids
  caching               = each.value.caching
  storage_account_type  = each.value.storage_account_type

  depends_on = [module.nic_infra]
}