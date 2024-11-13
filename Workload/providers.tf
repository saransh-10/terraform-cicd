terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.97.1"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.50.0"
    }
  }
}


provider "azurerm" {
  #client_id       = var.ARM_CLIENT_ID
  #client_secret   = var.ARM_CLIENT_SECRET
  #tenant_id       = var.ARM_TENANT_ID
  #subscription_id = var.ARM_SUBSCRIPTION_ID
  features {}
}

# Provider configuration for Databricks.
provider "databricks" {
  host                = var.databricks_host_name
  account_id          = var.databricks_account_id
  #azure_client_id     = var.ARM_CLIENT_ID
  #azure_client_secret = var.ARM_CLIENT_SECRET
  #azure_tenant_id     = var.ARM_TENANT_ID
}
