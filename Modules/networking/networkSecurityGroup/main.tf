resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.nsg_location
  resource_group_name = var.nsg_rg_name
  tags                = var.nsg_tags
  dynamic "security_rule" {
    for_each = var.sec_rule
    content {
    name                       = security_rule.value.name
    protocol                   = security_rule.value.protocol
    source_port_range          = security_rule.value.source_port_range
    destination_port_range     = security_rule.value.destination_port_range
    source_address_prefix      = security_rule.value.source_address_prefix
    destination_address_prefix = security_rule.value.destination_address_prefix
    access                     = security_rule.value.access
    priority                   = security_rule.value.priority
    direction                  = security_rule.value.direction
    }
  }
}
