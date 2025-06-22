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

variable "rt_name" {
  description = "Name of the route table"
  type        = string
}

variable "bgp_route_propagation_enabled" {
  description = "Enable BGP route propagation for the route table"
  type        = bool
  default     = true
}

variable "routes" {
  description = "List of security rules to apply to the Network Security Group"
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string, null)
  }))

  default = []
}