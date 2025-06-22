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

variable "func_name" {
  description = "Name of the function app"
  type        = string
}

variable "st_name" {
  description = "Name of the storage account"
  type        = string
}

variable "st_primary_access_key" {
  description = "Primary access key for the storage account"
  type        = string
}

variable "asp_id" {
  description = "ID of the App Service Plan"
  type        = string
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for the function app"
  type        = bool
  default     = false
}

variable "virtual_network_subnet_id" {
  description = "ID of the virtual network subnet to which the function app will be connected"
  type        = string
  default     = null
}