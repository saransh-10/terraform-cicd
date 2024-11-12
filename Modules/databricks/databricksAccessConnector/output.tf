output "access_id" {
  value = azurerm_databricks_access_connector.accessConnector.id
  description = "Id of access connector for assigning role to storage account."
}