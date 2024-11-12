variable "key_vault_id" {
  description = "(Optional) The ID of the Key Vault. Exactly one of key_vault_id, or key_vault_uri must be specified."
  type        = string
}

variable "key_name" {
  description = "(Required) The name of Key Vault Key."
  type        = string
}

variable "storage_account_id" {
  description = "value"
  type        = string
}
