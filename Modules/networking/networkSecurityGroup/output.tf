output "nsg_name" {
  value       = azurerm_network_security_group.nsg.name #var.new_or_existing == "new" ?  azurerm_network_security_group.nsg[0].name : data.azurerm_network_security_group.existing_nsg[0].name
  description = "The name of the Azure Network Security Group."
}
output "nsg_id" {
  value       = azurerm_network_security_group.nsg.id #var.new_or_existing == "new" ?  azurerm_network_security_group.nsg[0].id : data.azurerm_network_security_group.existing_nsg[0].id
  description = "The ID of the Azure Network Security Group."
}