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

variable "pep_name" {
  description = "Name of the private endpoint"
  type        = string
}

variable "snet_id" {
  description = "ID of the subnet where the private endpoint will be created"
  type        = string
}

variable "private_service_connections" {
  description = "List of private service connections for the private endpoint"
  type = list(object({
    name                           = string
    private_connection_resource_id = optional(string, null)
    is_manual_connection           = bool
    subresource_names              = optional(list(string), null)
  }))

  default = []
}