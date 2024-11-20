address_space_vnet = ["10.10.0.0/16"]
vnet_tags = {
  "owner" = "orica"
}
subnet_host_address_prefix      = ["10.10.0.0/24"]
subnet_container_address_prefix = ["10.10.1.0/24"]
subnet_pep_address_prefix       = ["10.10.2.0/24"]
nsg_tags = {
  "owner" = "orica"
}
PDZ_tags = {
  "owner" = "orica"
}
environment                   = "transit"
subnet_routetable_association = true
# Compute-
vm_machine_size   = "Standard_D2s_v3"
vm_admin_username = "admintest"
# Databricks
role_definition_name  = "Storage Blob Data Contributor"
container_access_type = "private"
network_access_adls   = true
databricksWorkspace = {
  sku = "premium"
}
tags = {
  "owner" = "orica"
}
infrastructure_encryption_enabled = true
publicNetworkAccessEnabled = false
# metastore
# For databricks authentication service principal
databricks_host_name  = "https://accounts.azuredatabricks.net/"
databricks_account_id = "4a194bb4-4fef-4d8a-add2-1c51a76a61b6"
# For metastore region
metastore_region = "westus2"
# Service Principle
# client_id       = "2f3d2b6f-e2ad-4ade-8c24-86f3c3afffcf"
# client_secret   = "9eY8Q~WK1iB2.2hL_4sLwu6eEZ7AfN0YvDISHcre"
# tenant_id       = "879756f6-3b3e-4e8d-a20f-d25e6d6d941f"
# subscription_id = "d4cdcc9b-a5dd-4e67-b0cd-bb10e7bb7f96"
routeTableName = ["routeTable-host", "routeTable-container", "routeTable-pep"]
