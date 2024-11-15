terraform {
  backend "azurerm" {
    resource_group_name  = "rg-databricks-tgrp-usc"
    storage_account_name = "stdatabrickstgrpusc01"
    container_name       = "tfstate"
    key                  = "testVM.tfstate"
  }
}
