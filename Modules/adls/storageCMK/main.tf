# This resource creates a customer-managed key for an Azure Storage Account, conditionally based on whether a key name is provided. It associates the key with the specified storage account and Key Vault.
resource "azurerm_storage_account_customer_managed_key" "storage_CMK" {
  count              = var.key_name != "" ? 1 : 0
  storage_account_id = var.storage_account_id
  key_vault_id       = var.key_vault_id
  key_name           = var.key_name
}
