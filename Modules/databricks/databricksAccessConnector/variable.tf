variable "databricksAccessConnectorName" {
  type = string
  description = "Name of the Databricks Access Connector to be created."
}

variable "location" {
  type        = string
  description = "The location (region) where the Databricks Access Connector will be created."
}

variable "rgName" {
  type        = string
  description = "The name of the Azure Resource Group where the Databricks Access Connector will be created."
}

variable "tags" {
  description = "A map of tags to assign to the Databricks Access Connector."
  type        = map(string)
}

variable "storage_account_id" {
  type = string
  description = "Storage account id for access connector role assignment"
}

variable "role_definition_name" {
  type = string
  description = "Role required Ex Storage Blob Data Contributor"
}