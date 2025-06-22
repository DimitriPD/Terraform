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

variable "pip_name" {
  description = "Name of the public IP"
  type        = string
}

variable "allocation_method" {
  description = "Allocation method for the public IP (Static or Dynamic)"
  type        = string
  default     = "Static"
}

variable "sku" {
  description = "SKU for the public IP (Basic or Standard)"
  type        = string
  default     = "Basic"
}