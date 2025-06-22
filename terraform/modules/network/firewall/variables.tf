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

variable "afw_name" {
  description = "Name of the Azure Firewall"
  type        = string
}

variable "sku_name" {
  description = "SKU name for the Azure Firewall"
  type        = string
}

variable "sku_tier" {
  description = "SKU tier for the Azure Firewall"
  type        = string
}

variable "firewall_policy_id" {
  description = "ID of the Azure Firewall Policy to associate with the firewall"
  type        = string
}

variable "snet_id" {
  description = "ID of the subnet where the Azure Firewall will be deployed"
  type        = string
}

variable "management_snet_id" {
  description = "ID of the management subnet for the Azure Firewall"
  type        = string
}

variable "pip_id" {
  description = "ID of the public IP address to associate with the Azure Firewall management configuration"
  type        = string
}