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

variable "afwp_name" {
  description = "Name of the Azure Firewall Policy"
  type        = string
}

variable "sku" {
  description = "SKU for the Azure Firewall Policy"
  type        = string
}