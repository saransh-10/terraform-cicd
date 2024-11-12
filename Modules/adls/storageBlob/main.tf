# This resource defines a storage blob in an Azure Storage Account, specifying its name, storage account name, container name, type, and source.
resource "azurerm_storage_blob" "blob" {
  name                   = var.storage_blob_name
  storage_account_name   = var.storage_account_name
  storage_container_name = var.storage_container_name
  type                   = var.storage_blob_type
  source                 = var.storage_blob_source
}
