address_space_vnet = ["10.10.0.0/16"]
vnet_tags = {
  "owner" = "orica"
}
subnet_host_address_prefix      = ["10.10.0.0/24"]
subnet_container_address_prefix = ["10.10.1.0/24"]
subnet_pep_address_prefix       = ["10.10.2.0/24"]
subnet_compute_address_prefix   = ["10.10.3.0/24"]
nsg_tags = {
  "owner" = "orica"
}
PDZ_tags = {
  "owner" = "orica"
}
org_name                      = "orica"
bu_name                       = "transit"
environment                   = "transit"
subnet_routetable_association = false
# Compute
vm_machine_size   = "Standard_B2s"
vm_admin_username = "admintest"
vm_admin_password = "Password@123"
# Databricks
rg_name               = "orica-transit-net-rg-01"
role_definition_name  = "Storage Blob Data Contributor"
container_access_type = "container"
network_access_adls   = true
databricksWorkspace = {
  sku = "premium"
}
tags = {
  "owner" = "orica"
}
publicNetworkAccessEnabled = true
existingVnetName           = "orica-transit-vnet-01"

# metastore
# For databricks authentication service principal
databricks_host_name  = "https://accounts.azuredatabricks.net/"
databricks_account_id = "4d49525d-9a29-4e03-8c1a-994ff431ce0d"

# For metastore region
metastore_region = "centralus"

# Existing Databricks information 
# workspaces = {
#   "orica-transit-dbwbg" = {
#     id = "3961089435610628"
#   },
# }

# Service Principle
#client_id       = "334c1b92-abaf-472f-916e-905ba89e0f3c"
#client_secret   = "jjg8Q~5ED2YE4KwQ1EnjkSuJmrrpSTEd2F33mbdw"
#tenant_id       = "bf5fa81f-9831-46a2-8bbf-6ca4c9a9eb4c"
#subscription_id = "367722a2-667e-40e3-ba4b-1078993dddf3"
