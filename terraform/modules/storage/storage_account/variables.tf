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

variable "st_name" {
  description = "Name of the storage account"
  type        = string
}

variable "account_tier" {
  description = "The tier of the storage account (e.g., Standard, Premium)"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "The replication type of the storage account (e.g., LRS, GRS)"
  type        = string
  default     = "LRS"
}