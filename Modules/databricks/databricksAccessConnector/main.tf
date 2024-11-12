resource "azurerm_databricks_access_connector" "accessConnector" {
  name                = var.databricksAccessConnectorName
  resource_group_name = var.rgName
  location            = var.location
  identity {
    type = "SystemAssigned"
  }
  tags                = var.tags
}

resource "azurerm_role_assignment" "role_assignment" {
  scope                = var.storage_account_id
  role_definition_name = var.role_definition_name
  principal_id         = azurerm_databricks_access_connector.accessConnector.identity[0].principal_id
}

# azurerm_databricks_access_connector.databricks_access_connector.identity[0].principal_id