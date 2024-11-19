terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.10.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.50.0"
    }
  }
}
provider "azurerm" {
  # client_id       = var.client_id
  # client_secret   = var.client_secret
  # tenant_id       = var.tenant_id
  # subscription_id = var.subscription_id
  features {}
}
# Provider configuration for Databricks.
provider "databricks" {
  host                = var.databricks_host_name
  account_id          = var.databricks_account_id
  # azure_client_id     = var.client_id
  # azure_client_secret = var.client_secret
  # azure_tenant_id     = var.tenant_id
}
