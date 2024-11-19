resource "azurerm_key_vault_secret" "KeyVaultSecret" {
  name = var.Key_Vault_Secret.name
  value = var.secret_value
  key_vault_id = var.Key_Vault_Id
  content_type = "Password"
  expiration_date = "2025-12-31T23:59:59Z"
}
