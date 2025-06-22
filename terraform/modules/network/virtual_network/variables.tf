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

variable "address_space" {
  description = "Address space for the virtual network in CIDR notation"
  type        = list(string)

  default = ["10.0.0.0/16"]
}

variable "private_endpoint_vnet_policies" {
  description = "Private endpoint policies for the virtual network"
  type        = string

  default = "Disabled"
}