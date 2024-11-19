resource "azurerm_key_vault" "Key_Vault" {
  name                       = var.Key_Vault.name
   resource_group_name           = var.resource_group_name
  location                      = var.location
  enabled_for_disk_encryption = var.Key_Vault.enabled_for_disk_encryption
  tenant_id                  = var.Key_Vault.tenant_id
  soft_delete_retention_days = var.Key_Vault.soft_delete_retention_days
  purge_protection_enabled   = var.Key_Vault.purge_protection_enabled
  enable_rbac_authorization = var.Key_Vault.enable_rbac_authorization
  sku_name = var.Key_Vault.sku_name
  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
  }
  # access_policy {
  #   tenant_id           = var.Key_Vault.access_policy.tenant_id
  #   object_id           = var.Key_Vault.access_policy.object_id
  #   secret_permissions  = var.Key_Vault.access_policy.secret_permissions
  #   key_permissions = var.Key_Vault.access_policy.key_permissions
  # }
  tags = var.Tags
}
