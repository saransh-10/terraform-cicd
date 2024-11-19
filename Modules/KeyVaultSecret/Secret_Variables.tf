variable "Key_Vault_Secret" {
  description = "Details regarding Key Vault Secret"
  type = object({
      name = string
    })
}
variable "Key_Vault_Id" {
  type = string
  description = "keyvault ID"
}
variable "secret_value" {
  type =string
  description = "Keyvault secret"
}
