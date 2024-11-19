variable "storage_account_name" {
  description = "(Required) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
  type        = string
}
variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the storage account."
  type        = string
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists."
  type        = string
}
variable "storage_account_tier" {
  description = "(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid."
  type        = string
  default     = "Standard"
}
# Variable for public access
variable "network_rule" {
  type        = bool
  description = "True to enable Public access otherwise False"
}
variable "account_replication_type" {
  description = "(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa."
  type        = string
  default     = "LRS"
}
variable "is_hns_enabled" {
  description = "(Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2"
  type        = bool
  default     = true
}
variable "storage_identity_type" {
  description = "(Required) Specifies the type of Managed Service Identity that should be configured on this Storage Account. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both)."
  type        = string
  default     = "SystemAssigned"
}
variable "storage_identity_id" {
  description = "Storage identity ID"
  type        = list(string)
}
