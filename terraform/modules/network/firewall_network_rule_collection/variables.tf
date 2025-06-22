variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

variable "afw_name" {
  description = "Name of the Azure Firewall"
  type        = string
}

variable "afw_net_coll_name" {
  description = "Name of the Azure Firewall Network Rule Collection"
  type        = string
}

variable "priority" {
  description = "Priority of the Azure Firewall Network Rule Collection"
  type        = number
}

variable "action" {
  description = "Action of the Azure Firewall Network Rule Collection (Allow/Deny)"
  type        = string
}

variable "rules" {
  description = "List of rules for the Azure Firewall Network Rule Collection"
  type = list(object({
    name                  = string
    source_addresses      = list(string)
    destination_ports     = list(string)
    destination_addresses = list(string)
    protocols             = list(string)
  }))
}