terraform {
  backend "azurerm" {
    resource_group_name  = "Kartikeya-it-infra"
    storage_account_name = "oricademoaccount"
    container_name       = "demo"
    key                  = "test.tfstate"
   # client_id       = "2f3d2b6f-e2ad-4ade-8c24-86f3c3afffcf"
   # client_secret   = "9eY8Q~WK1iB2.2hL_4sLwu6eEZ7AfN0YvDISHcre"
   # tenant_id       = "879756f6-3b3e-4e8d-a20f-d25e6d6d941f"
   # subscription_id = "d4cdcc9b-a5dd-4e67-b0cd-bb10e7bb7f96"
  }
}
