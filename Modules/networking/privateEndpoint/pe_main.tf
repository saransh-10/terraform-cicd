resource "azurerm_private_endpoint" "pep" {
  name                          = var.peName
  location                      = var.location
  resource_group_name           = var.rgName
  subnet_id                     = var.peSubnetId
  custom_network_interface_name = var.peNicName
  private_service_connection {
    name                           = var.serviceConnectionName
    private_connection_resource_id = var.privateResourceId
    subresource_names              = var.subresourceNames
    is_manual_connection           = var.isManualConnection
    request_message                = var.isManualConnection== false? null : "Create Private Endpoint" 
  }
  dynamic "private_dns_zone_group" {
    for_each = var.privateDnsZoneGroupCondition ? { "element" = 1 } : {}
    content {
      name                 = var.dnsZoneGroupName
      private_dns_zone_ids = [var.privateDnsZoneIds]
    }
  }
}

