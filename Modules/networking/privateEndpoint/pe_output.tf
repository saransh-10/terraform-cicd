output "pepName" {
  value = azurerm_private_endpoint.pep.name
  description = "name of the private end point"
}

output "pepId" {
  value = azurerm_private_endpoint.pep.id
  description = "id of the private end point"
}