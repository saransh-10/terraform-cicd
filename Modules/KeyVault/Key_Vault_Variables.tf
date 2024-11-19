variable "Key_Vault" {
  description = "Details regarding Key Vault"
  type = object({
    name                       = string
    tenant_id                  = string
    enabled_for_disk_encryption = bool
    enable_rbac_authorization = bool
    soft_delete_retention_days = number
    purge_protection_enabled   = bool
    sku_name                   = string
    # access_policy = object({
    #   tenant_id           = string
    #   object_id           = string
    #   secret_permissions  = list(string)
    #   key_permissions = list(string)
    # })
  })
}
variable "Tags" {
  description = "Name of the Tag"
  type        = map(string)
}
variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the storage account."
  type        = string
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists."
  type        = string
}
