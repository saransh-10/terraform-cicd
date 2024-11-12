terraform {
  backend "azurerm" {
    resource_group_name  = "Orica-RG"
    storage_account_name = "oricatest3"
    container_name       = "tfstate"
    key                  = "terraform1.tfstate"
    # client_id            = "334c1b92-abaf-472f-916e-905ba89e0f3c"
    # client_secret        = "jjg8Q~5ED2YE4KwQ1EnjkSuJmrrpSTEd2F33mbdw"
    # tenant_id            = "bf5fa81f-9831-46a2-8bbf-6ca4c9a9eb4c"
    # subscription_id      = "367722a2-667e-40e3-ba4b-1078993dddf3"
  }
}
