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
  features {}
}

# Provider configuration for Databricks.
provider "databricks" {
  host                = var.databricks_host_name
  account_id          = var.databricks_account_id
}
