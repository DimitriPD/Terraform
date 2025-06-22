locals {
  firewall_policy_id = var.firewall_policy_id
  afwp_rcg_name      = var.afwp_rcg_name
  priority           = var.priority
  collections        = var.collections
}

resource "azurerm_firewall_policy_rule_collection_group" "afwp_rcg" {
  firewall_policy_id = local.firewall_policy_id
  name               = local.afwp_rcg_name
  priority           = local.priority

  dynamic "network_rule_collection" {
    for_each = local.collections
    content {
      name     = network_rule_collection.value.name
      action   = network_rule_collection.value.action
      priority = network_rule_collection.value.priority

      dynamic "rule" {
        for_each = network_rule_collection.value.rules
        content {
          name                  = rule.value.name
          source_addresses      = rule.value.source_addresses
          destination_ports     = rule.value.destination_ports
          destination_addresses = rule.value.destination_addresses
          protocols             = rule.value.protocols
        }
      }
    }
  }
}