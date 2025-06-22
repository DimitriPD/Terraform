locals {
  rg_name           = var.rg_name
  afw_name          = var.afw_name
  afw_net_coll_name = var.afw_net_coll_name
  priority          = var.priority
  action            = var.action
  rules             = var.rules
}

resource "azurerm_firewall_network_rule_collection" "afw_net_coll" {
  resource_group_name = local.rg_name
  azure_firewall_name = local.afw_name
  name                = local.afw_net_coll_name
  priority            = local.priority
  action              = local.action

  dynamic "rule" {
    for_each = local.rules

    content {
      name                  = rule.value.name
      source_addresses      = rule.value.source_addresses
      destination_ports     = rule.value.destination_ports
      destination_addresses = rule.value.destination_addresses
      protocols             = rule.value.protocols
    }
  }
}