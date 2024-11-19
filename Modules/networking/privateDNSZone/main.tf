# Deploys an Azure Private DNS Zone with the given name, resource group, and tags.
resource "azurerm_private_dns_zone" "dns_Zone" {
  name                = var.private_dns_zone_name
  resource_group_name = var.private_dns_zone_resource_group_name
  tags                = var.private_dns_zone_tags
}
