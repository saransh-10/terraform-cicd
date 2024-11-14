terraform {
  backend "azurerm" {
    resource_group_name  = "Orica-RG"
    storage_account_name = "oricatest3"
    container_name       = "tfstate"
    key                  = "terraform1.tfstate"
  }
}
