# This resource creates an Azure Storage Account with specified configurations, including its name, resource group, location, tier, replication type, HNS status, and identity settings.
resource "azurerm_storage_account" "storage" {
  name                          = var.storage_account_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = var.storage_account_tier
  account_replication_type      = var.account_replication_type
  is_hns_enabled                = var.is_hns_enabled
  public_network_access_enabled = var.network_rule
  identity {
    type         = var.storage_identity_type
    identity_ids = var.storage_identity_type == "SystemAssigned" ? [] : var.storage_identity_id
  }

  # This block specifies lifecycle settings for AKS, ignoring changes based on the provided lifecycle configuration.
  # lifecycle {
  #   ignore_changes = [var.lifecycle_ignore_changes]
  # }
}
