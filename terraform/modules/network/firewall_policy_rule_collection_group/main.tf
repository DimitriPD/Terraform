locals {
  firewall_policy_id = var.firewall_policy_id
  afwp_rcg_name      = var.afwp_rcg_name
  priority           = var.priority
  action             = var.action
  rules              = var.rules
}

resource "azurerm_firewall_policy_rule_collection_group" "afwp_rcg" {
  firewall_policy_id = local.firewall_policy_id
  name               = local.afwp_rcg_name
  priority           = local.priority

  dynamic "network_rule_collection" {
    for_each = local.rules
    content {
      name     = network_rule_collection.value.name
      action   = local.action
      priority = local.priority

      rule {
        name                  = network_rule_collection.value.name
        source_addresses      = network_rule_collection.value.source_addresses
        destination_ports     = network_rule_collection.value.destination_ports
        destination_addresses = network_rule_collection.value.destination_addresses
        protocols             = network_rule_collection.value.protocols
      }
    }
  }
}