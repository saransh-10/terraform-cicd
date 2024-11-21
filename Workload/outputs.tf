output "subnet_pep_id" {
  value       = module.subnet_pep.subnet_id
  description = "Private Endpoint Subnet ID"
}
output "private_dns_zone_id_blob" {
  value       = module.private_dns_zone[0].private_dns_zone_id
  description = "Private DNS Zone Blob resource ID"
}
output "private_dns_zone_id_dfs" {
  value       = module.private_dns_zone[1].private_dns_zone_id
  description = "Private DNS Zone DFS resource ID"
}
output "private_dns_zone_id_db" {
  value       = module.private_dns_zone[2].private_dns_zone_id
  description = "Private DNS Zone Databricks resource ID"
}
output "appResource_group_name" {
  value       = data.azurerm_resource_group.AppRG
  description = "Resource Group name (PaaS)"
}
output "appResource_group_location" {
  value       = data.azurerm_resource_group.AppRG.location
  description = "Resource group Location (Paas)"
}
output "netResource_group_name" {
  value       = data.azurerm_resource_group.NetworkRG.name
  description = "Resource Group name (Network)"
}
output "netResource_group_location" {
  value       = data.azurerm_resource_group.NetworkRG.location
  description = "Resource group Location (Network)"
}
# Databricks output
output "databricks_id" {
  value       = module.databricksWorkspace.databricksWorkspaceId
  description = "Databricks Workspace Id."
}
# ADLS Workload Output
output "acc_id" {
  value       = module.databricksAccessConnector.access_id
  description = "Access Connector Id."
}
output "storage_account_id" {
  value       = module.ADLSGen2.storage_account_id
  description = "Storage account Id."
}
output "storage_account_name" {
  value       = local.storage_account_name
  description = "Storage account name."
}
output "storage_container_name" {
  value       = local.storage_container_metastore_name
  description = "Storage Container name."
}
output "storage_container_name_ext" {
  value       = local.storage_container_ext_name
  description = "Storage Container name for external location."
}
