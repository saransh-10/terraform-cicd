variable "metastore_name" {
  type        = string
  description = "Name of the metastore."
}
# variable "metastore_owner" {
#   type        = string
#   description = "Username/groupname/sp application_id of the metastore owner."
# }
variable "metastore_region" {
  type        = string
  description = "(Mandatory for account-level) The region of the metastore"
}

variable "adls_name" {
  type        = string
  description = "(Mandatory for account-level) The region of the metastore"
}

variable "acc_name" {
  type        = string
  description = "(Mandatory for account-level) The region of the metastore"
}



