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
org_name                      = "orica"
bu_name                       = "transit"
environment                   = "transit"
subnet_routetable_association = false
# Compute
vm_machine_size   = "Standard_B2s"
vm_admin_username = "admintest"
vm_admin_password = "Password@123"
# Databricks
role_definition_name  = "Storage Blob Data Contributor"
container_access_type = "container"
network_access_adls   = true
databricksWorkspace = {
  sku = "premium"
}
tags = {
  "owner" = "orica"
}
publicNetworkAccessEnabled = false
# metastore
# For databricks authentication service principal
databricks_host_name  = "https://accounts.azuredatabricks.net/"
databricks_account_id = "4d49525d-9a29-4e03-8c1a-994ff431ce0d"
# For metastore region
metastore_region = "centralus"
# Service Principle
# RG_Location = "West US"
Key_Vault = {
  name                       = "kvoricatrnsit01"
  tenant_id                  = "879756f6-3b3e-4e8d-a20f-d25e6d6d941f"
  soft_delete_retention_days = 7
  enabled_for_disk_encryption = true
  purge_protection_enabled   = false
  enable_rbac_authorization = true
  sku_name                   = "standard"
  # access_policy = {
  #   secret_permissions  = [
  #                       "Get",
  #                       "List",
  #                       "Set",
  #                       "Delete",
  #                       "Recover",
  #                       "Backup",
  #                       "Restore"
  #                   ]
  #   key_permissions = [
  #                       "Get",
  #                       "List",
  #                       "Update",
  #                       "Create",
  #                       "Import",
  #                       "Delete",
  #                       "Recover",
  #                       "Backup",
  #                       "Restore",
  #                       "GetRotationPolicy",
  #                       "SetRotationPolicy",
  #                       "Rotate"
  #                   ]
  # }
}
Key_Vault_Secret = {
  name = "vmpass"
}
