terraform {
  backend "azurerm" {
    resource_group_name  = "Orica-RG"
    storage_account_name = "oricatest3"
    container_name       = "tfstate"
    key                  = "terraform1.tfstate"
    #client_id            = "${var.ARM_CLIENT_ID}"
    #client_secret        = "${var.ARM_CLIENT_SECRET}"
    #tenant_id            = "${var.ARM_TENANT_ID}"
    #subscription_id      = "${var.ARM_SUBSCRIPTION_ID}"
  }
}
