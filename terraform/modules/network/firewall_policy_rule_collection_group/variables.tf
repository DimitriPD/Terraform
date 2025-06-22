variable "firewall_policy_id" {
  description = "ID of the Azure Firewall Policy"
  type        = string
}

variable "afwp_rcg_name" {
  description = "Name of the Azure Firewall Policy Rule Collection Group"
  type        = string
}

variable "priority" {
  description = "Priority of the Azure Firewall Network Rule Collection"
  type        = number
}

variable "collections" {
  description = "List of collections for the Azure Firewall Policy Rule Collection Group"
  type = list(object({
    name     = string
    action   = string
    priority = number
    rules = list(object({
      name                  = string
      source_addresses      = list(string)
      destination_ports     = list(string)
      destination_addresses = list(string)
      protocols             = list(string)
    }))
  }))
}