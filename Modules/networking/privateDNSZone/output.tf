output "private_dns_zone_id" {
  description = "Output: Private DNS Zone resource object."
  value       = azurerm_private_dns_zone.dns_Zone.id
}