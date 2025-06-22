variable "env" {
  description = "Environment for the resource group (e.g., dev, prod)"
  type        = string
}

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

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "snet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "address_prefixes" {
  description = "Address prefixes for the subnet"
  type        = list(string)
}

variable "private_endpoint_network_policies" {
  description = "Enable or disable private endpoint network policies"
  type        = string
  default     = "Enabled"
}