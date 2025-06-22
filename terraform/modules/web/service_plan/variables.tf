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

variable "asp_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "os_type" {
  description = "Operating system type for the App Service Plan (e.g., Linux, Windows)"
  type        = string
}

variable "sku_name" {
  description = "SKU name for the App Service Plan (e.g., P1v2, S1)"
  type        = string
}