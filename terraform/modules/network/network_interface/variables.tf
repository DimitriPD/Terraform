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

variable "nic_name" {
  description = "Name of the network interface"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where the network interface will be created"
  type        = string
}