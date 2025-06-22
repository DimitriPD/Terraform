variable "region" {
  description = "Azure region where the resource group will be created"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the resource group"
  type        = map(string)
}

variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "size" {
  description = "Size of the virtual machine"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the virtual machine"
  type        = string
}

variable "admin_password" {
  description = "Admin password for the virtual machine"
  type        = string
  sensitive   = true
}

variable "network_interface_ids" {
  description = "List of network interface IDs to attach to the virtual machine"
  type        = list(string)
}

variable "caching" {
  description = "Caching type for the OS disk"
  type        = string
  default     = "ReadWrite"
}

variable "storage_account_type" {
  description = "Storage account type for the OS disk"
  type        = string
  default     = "Standard_LRS"
}