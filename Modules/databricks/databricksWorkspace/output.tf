output "databricksWorkspaceUrl" {
  value       = azurerm_databricks_workspace.databricks.workspace_url
  description = "Output for Azure Databricks workspace URL."
}
output "databricksWorkspaceId" {
  value       = azurerm_databricks_workspace.databricks.id
  description = "Output for Azure Databricks Resource ID."
}