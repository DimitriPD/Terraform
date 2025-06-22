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

variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
}

variable "security_rules" {
  description = "List of security rules to apply to the Network Security Group"
  type = list(object({
    name                                       = string
    description                                = optional(string, null)
    protocol                                   = string
    source_port_range                          = optional(string, null)
    source_port_ranges                         = optional(list(string), null)
    destination_port_range                     = optional(string, null)
    destination_port_ranges                    = optional(list(string), null)
    source_address_prefix                      = optional(string, null)
    source_address_prefixes                    = optional(list(string), null)
    source_application_security_group_ids      = optional(list(string), null)
    destination_address_prefix                 = optional(string, null)
    destination_address_prefixes               = optional(list(string), null)
    destination_application_security_group_ids = optional(list(string), null)
    access                                     = string
    priority                                   = number
    direction                                  = string
  }))

  default = []
}