# ......................................................
# Creating New Resource Group
# ......................................................
# module "RG" {
#   source                  = "../Modules/rg"
#   resource_group_name     = local.resource_group_name
#   resource_group_location = data.azurerm_resource_group.NetworkRG.location
# }
# ......................................................
# Creating New Virtual Network
# ......................................................
# module "vnet" {
#   source                        = "../Modules/networking/virtualNetwork"
#   new_virtual_network_name      = local.VNet_Name
#   virtual_network_location      = data.azurerm_resource_group.NetworkRG.location
#   virtual_network_address_space = local.address_space_vnet
#   resource_group_name           = data.azurerm_resource_group.AppRG.name
#   virtual_network_tags          = var.vnet_tags
# }
# ......................................................
# Creation of Host Subnet
# ......................................................
module "subnet_host" {
  source                                        = "../Modules/networking/subnet"
  subnet_name                                   = local.subnet_host_name
  subnet_address_prefixes                       = var.subnet_host_address_prefix
  subnet_rg_name                                = data.azurerm_resource_group.NetworkRG.name
  virtual_network_name                          = data.azurerm_virtual_network.NetworkVNet.name
  subnet_delegations                            = local.subnet_delegation
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  nsg_id                                        = module.nsg_snet_host.nsg_id
  subnet_rt_association                         = var.subnet_routetable_association
  virtual_network_location                      = data.azurerm_resource_group.NetworkRG.location
  routeTableName                                = var.routeTableName[0]
}
# ......................................................
# Creation of Container Subnet
# ......................................................
module "subnet_container" {
  source                                        = "../Modules/networking/subnet"
  subnet_name                                   = local.subnet_container_name
  subnet_address_prefixes                       = var.subnet_container_address_prefix
  subnet_rg_name                                = data.azurerm_resource_group.NetworkRG.name
  virtual_network_name                          = data.azurerm_virtual_network.NetworkVNet.name
  subnet_delegations                            = local.subnet_delegation
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  nsg_id                                        = module.nsg_snet_container.nsg_id
  subnet_rt_association                         = var.subnet_routetable_association
  virtual_network_location                      = data.azurerm_resource_group.NetworkRG.location
  routeTableName                                = var.routeTableName[1]
}
# ......................................................
# Creation of Private Endpoint Subnet
# ......................................................
module "subnet_pep" {
  source                                        = "../Modules/networking/subnet"
  subnet_name                                   = local.subnet_pep_name
  subnet_address_prefixes                       = var.subnet_pep_address_prefix
  subnet_rg_name                                = data.azurerm_resource_group.NetworkRG.name
  virtual_network_name                          = data.azurerm_virtual_network.NetworkVNet.name
  subnet_delegations                            = local.subnet_delegation_null
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  subnet_nsg_association                        = false
  subnet_rt_association                         = var.subnet_routetable_association
  virtual_network_location                      = data.azurerm_resource_group.NetworkRG.location
  routeTableName                                = var.routeTableName[2]
}
# ......................................................
# Creation of NSG for Compute
# ......................................................
module "nsg_compute" {
  source       = "../Modules/networking/networkSecurityGroup"
  nsg_name     = local.nsg_compute_name
  nsg_location = data.azurerm_resource_group.NetworkRG.location
  nsg_rg_name  = data.azurerm_resource_group.NetworkRG.name
  # sec_rule     = []
  nsg_tags   = var.nsg_tags
}
# ......................................................
# Creation of NSG for Host
# ......................................................
module "nsg_snet_host" {
  source       = "../Modules/networking/networkSecurityGroup"
  nsg_name     = local.nsg_snet_host_name
  nsg_location = data.azurerm_resource_group.NetworkRG.location
  nsg_rg_name  = data.azurerm_resource_group.NetworkRG.name
  # sec_rule     = null
  nsg_tags   = var.nsg_tags
}
# ......................................................
# Creation of NSG for Container
# ......................................................
module "nsg_snet_container" {
  source       = "../Modules/networking/networkSecurityGroup"
  nsg_name     = local.nsg_snet_container_name
  nsg_location = data.azurerm_resource_group.NetworkRG.location
  nsg_rg_name  = data.azurerm_resource_group.NetworkRG.name
  # sec_rule     = null
  nsg_tags   = var.nsg_tags
}
# ......................................................
# Creating Private DNS Zone
# ......................................................
module "private_dns_zone" {
  source                               = "../Modules/networking/privateDNSZone"
  count                                = length(local.private_dns_zone_name)
  private_dns_zone_name                = element(local.private_dns_zone_name, count.index)
  private_dns_zone_resource_group_name = data.azurerm_resource_group.NetworkRG.name
  private_dns_zone_tags                = var.PDZ_tags
}
# ......................................................
# Creating Private DNS Zone Vnet Link
# ......................................................
module "Vnet_Link" {
  source                                = "../Modules/networking/virtualNetworkLink"
  count                                 = length(local.private_dns_zone_name)
  private_dns_link_name                 = local.Virtual_Network_Link_Name
  private_dns_link_registration_enabled = local.private_dns_link_registration_enabled
  private_dns_link_resource_group_name  = data.azurerm_resource_group.NetworkRG.name
  private_dns_link_virtual_network_id   = data.azurerm_virtual_network.NetworkVNet.id
  private_dns_link_zone_name            = element(local.private_dns_zone_name, count.index)
  private_dns_link_tags                 = var.PDZ_tags
  depends_on                            = [module.private_dns_zone]
}
# Compute Workload
# ......................................................
# Creating Compute for SHIR/SHA only for Transit RG
# ......................................................
module "compute" {
  count                  = var.environment == "transit" ? 1 : 0
  source                 = "../Modules/vm-linux"
  vm_admin_username      = var.vm_admin_username
  vm_machine_size        = var.vm_machine_size
  nic_subnet_id          = module.subnet_pep.subnet_id
  vm_location            = data.azurerm_resource_group.NetworkRG.location
  vm_resource_group_name_nic = data.azurerm_resource_group.NetworkRG.name
  vm_name                = local.vm_machine_name
  network_interface_name = local.network_interface_name
  vm_os_disk             = local.vm_os_disk
  vm_resource_group_name = data.azurerm_resource_group.AppRG.name
  vm_image_reference     = local.vm_image_reference
  vm_public_key          = null
  admin_ssh_key          = null
  admin_password         = local.vm_admin_password
}
# Databricks Workload
# ......................................................
# Creating ADLSGen2 for metastore
# ......................................................
module "ADLSGen2" {
  source                            = "../Modules/adls/storageAccount"
  resource_group_name               = data.azurerm_resource_group.NetworkRG.name
  location                          = data.azurerm_resource_group.NetworkRG.location
  storage_account_name              = local.storage_account_name
  account_replication_type      = local.account_replication_type
  storage_identity_id               = ["SystemAssigned"]
  network_rule                      = var.network_access_adls
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
}
# ......................................................
# Creating Container for metastore
# ......................................................
module "container_metastore" {
  count                  = var.environment == "transit" ? 1 : 0
  source                 = "../Modules/adls/container"
  storage_account_name   = local.storage_account_name
  storage_container_name = local.storage_container_metastore_name
  container_access_type  = var.container_access_type
  depends_on             = [module.ADLSGen2]
}
# ......................................................
# Creating Container for external Location
# ......................................................
module "container_external_location" {
  count                  = var.environment == "transit" ? 0 : 1
  source                 = "../Modules/adls/container"
  storage_account_name   = local.storage_account_name
  storage_container_name = local.storage_container_ext_name
  container_access_type  = var.container_access_type
  depends_on             = [module.ADLSGen2]
}
# ......................................................
# Module: Azure Databricks Access Connector
# ......................................................
module "databricksAccessConnector" {
  source                        = "../Modules/databricks/databricksAccessConnector"
  databricksAccessConnectorName = local.access_connector_name
  location                      = data.azurerm_resource_group.NetworkRG.location
  rgName                        = data.azurerm_resource_group.AppRG.name
  tags                          = var.tags
  storage_account_id            = module.ADLSGen2.storage_account_id
  role_definition_name          = var.role_definition_name
  depends_on                    = [module.ADLSGen2]
}
# ......................................................
# Module: Azure Databricks Workspace
# ......................................................
module "databricksWorkspace" {
  source                            = "../Modules/databricks/databricksWorkspace"
  databricksName                    = local.db_name
  resourceGroupName                 = data.azurerm_resource_group.AppRG.name
  location                          = data.azurerm_resource_group.NetworkRG.location
  databricksNoPublicIp              = true
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  databricksPrivateNSGId            = module.nsg_snet_container.nsg_id
  databricksPrivateSubnetName       = module.subnet_container.subnet_name
  databricksPublicNSGId             = module.nsg_snet_host.nsg_id
  databricksPublicSubnetName        = module.subnet_host.subnet_name
  databricksVnetId                  = data.azurerm_virtual_network.NetworkVNet.id
  databricksSku                     = var.databricksWorkspace.sku
  publicNetworkAccessEnabled        = var.publicNetworkAccessEnabled
  tags                              = var.tags
  depends_on                        = [module.databricksAccessConnector, module.ADLSGen2]
}
# ..........................................................................
# Module: Browser Authentication Private Endpoint for Databricks Workspace
# ..........................................................................
module "databricksBrowsAuthPEP" {
  count                        = var.environment == "transit" ? 1 : 0
  source                       = "../Modules/networking/privateEndpoint"
  peName                       = local.db_browsauth_pe_name
  location                     = data.azurerm_resource_group.NetworkRG.location
  rgName                       = data.azurerm_resource_group.NetworkRG.name
  peSubnetId                   = module.subnet_pep.subnet_id
  peNicName                    = local.db_browsauth_pe_nic_name
  serviceConnectionName        = local.db_browsauth_pe_service_name
  privateResourceId            = module.databricksWorkspace.databricksWorkspaceId
  subresourceNames             = local.TargetSubresource.dbbrowsAuthPeSubresourceNames
  dnsZoneGroupName             = local.db_browsauth_pe_dns_group_name
  privateDnsZoneGroupCondition = true
  privateDnsZoneIds            = module.private_dns_zone[2].private_dns_zone_id
}
# ..........................................................
# Module: UI-API Private Endpoint for Databricks Workspace
# ..........................................................
module "databricksUiApiPEP" {
  source                       = "../Modules/networking/privateEndpoint"
  peName                       = local.db_uiapi_pe_name
  location                     = data.azurerm_resource_group.NetworkRG.location
  rgName                       = data.azurerm_resource_group.NetworkRG.name
  peSubnetId                   = module.subnet_pep.subnet_id
  peNicName                    = local.db_uiapi_pe_nic_name
  serviceConnectionName        = local.db_uiapi_pe_service_name
  privateResourceId            = module.databricksWorkspace.databricksWorkspaceId
  subresourceNames             = local.TargetSubresource.dbUiApiPeSubresourceNames
  dnsZoneGroupName             = local.db_uiapi_pe_dns_group_name
  privateDnsZoneGroupCondition = true
  privateDnsZoneIds            = module.private_dns_zone[2].private_dns_zone_id
}
# ......................................................
# Module: DFS Private Endpoint for Storage Account
# ......................................................
module "adlsGen2DfsPEP" {
  source                       = "../Modules/networking/privateEndpoint"
  peName                       = local.adls_dfs_pe_name
  location                     = data.azurerm_resource_group.NetworkRG.location
  rgName                       = data.azurerm_resource_group.NetworkRG.name
  peSubnetId                   = module.subnet_pep.subnet_id
  peNicName                    = local.adls_dfs_pe_nic_name
  serviceConnectionName        = local.adls_dfs_pe_service_name
  privateResourceId            = module.ADLSGen2.storage_account_id
  subresourceNames             = local.TargetSubresource.adlsGen2DfsPeSubresourceNames
  dnsZoneGroupName             = local.adls_dfs_pe_dns_group_name
  privateDnsZoneGroupCondition = true
  privateDnsZoneIds            = module.private_dns_zone[1].private_dns_zone_id
}
# ......................................................
# Module: Blob Private Endpoint for Storage Account
# ......................................................
module "adlsGen2BlobPEP" {
  source                       = "../Modules/networking/privateEndpoint"
  peName                       = local.adls_blob_pe_name
  location                     = data.azurerm_resource_group.NetworkRG.location
  rgName                       = data.azurerm_resource_group.NetworkRG.name
  peSubnetId                   = module.subnet_pep.subnet_id
  peNicName                    = local.adls_blob_pe_nic_name
  serviceConnectionName        = local.adls_blob_pe_service_name
  privateResourceId            = module.ADLSGen2.storage_account_id
  subresourceNames             = local.TargetSubresource.adlsGen2BlobPeSubresourceNames
  dnsZoneGroupName             = local.adls_blob_pe_dns_group_name
  privateDnsZoneGroupCondition = true
  privateDnsZoneIds            = module.private_dns_zone[0].private_dns_zone_id
}
# Metastore Workload
# Module to create the Databricks metastore.
module "metastore_creation" {
  count            = var.environment == "transit" ? 1 : 0
  source           = "../Modules/databricks/databricks-metastore-creation"
  metastore_name   = local.metastore_name
  metastore_region = var.metastore_region
  adls_name        = local.metastore_storage_container_name
  acc_name         = module.databricksAccessConnector.access_id
  depends_on       = [module.databricksWorkspace, module.ADLSGen2, module.databricksAccessConnector]
}
# Module to assign the created metastore to the Databricks workspaces.
module "metastore_workspace_assignment_transit" {
  count         = var.environment == "transit" ? 1 : 0
  source        = "../Modules/databricks/databricks-metastore-workspace-assignment"
  metastore_id  = module.metastore_creation[0].metastore_id
  workspace_ids = split("-", split(".", module.databricksWorkspace.databricksWorkspaceUrl)[0])[1]
}
# Module to assign the created metastore to the Databricks workspaces if metastore is already created.
module "metastore_workspace_assignment" {
  count         = var.environment == "transit" ? 0 : 1
  source        = "../Modules/databricks/databricks-metastore-workspace-assignment"
  metastore_id  = data.databricks_metastores.all[0].ids["westus2"]
  workspace_ids = split("-", split(".", module.databricksWorkspace.databricksWorkspaceUrl)[0])[1]
}
