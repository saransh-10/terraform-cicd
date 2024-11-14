# Creates a virtual network link for an Azure Private DNS zone, enabling registration and associating it with a specified virtual network.
resource "azurerm_private_dns_zone_virtual_network_link" "virtual_network_link" {
  name                  = var.private_dns_link_name
  registration_enabled  = var.private_dns_link_registration_enabled
  resource_group_name   = var.private_dns_link_resource_group_name
  private_dns_zone_name = var.private_dns_link_zone_name
  virtual_network_id    = var.private_dns_link_virtual_network_id
  tags                  = var.private_dns_link_tags
}
