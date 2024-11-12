output "subnet_name" {
  value       = azurerm_subnet.subnets.name
  description = "The name of the Azure Subnet."
}

output "subnet_id" {
  value       = azurerm_subnet.subnets.id
  description = "The ID of the Azure Subnet."
}

# output "subnet_nsg_association_id" {
#   value = azurerm_subnet_network_security_group_association.nsg_association[0].id
#   description = "subnet network security group association id"
# }