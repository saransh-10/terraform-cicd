# ......................................................
# Creating New Resource Group
# ......................................................
module "RG" {
  source                  = "../Modules/rg"
  resource_group_name     = local.resource_group_name
  resource_group_location = local.location
}

# ......................................................
# Creating New Virtual Network
# ......................................................
module "vnet" {
  source                        = "../Modules/networking/virtualNetwork"
  new_virtual_network_name      = local.virtual_network_name
  virtual_network_location      = local.location
  virtual_network_address_space = local.address_space_vnet
  resource_group_name           = module.RG.resource_group_name
  virtual_network_tags          = var.vnet_tags
}

# ......................................................
# Creation of Host Subnet
# ......................................................
module "subnet_host" {
  source                                        = "../Modules/networking/subnet"
  subnet_name                                   = local.subnet_host_name
  subnet_address_prefixes                       = var.subnet_host_address_prefix
  subnet_rg_name                                = module.RG.resource_group_name
  virtual_network_name                          = module.vnet.virtual_network_name
  location                                      = local.location
  subnet_delegations                            = local.subnet_delegation
  service_endpoints                             = local.service_endpoints
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  nsg_id                                        = module.nsg_snet_host.nsg_id
  subnet_rt_association                         = false
}

# ......................................................
# Creation of Container Subnet 
# ......................................................
module "subnet_container" {
  source                                        = "../Modules/networking/subnet"
  subnet_name                                   = local.subnet_container_name
  subnet_address_prefixes                       = var.subnet_container_address_prefix
  subnet_rg_name                                = module.RG.resource_group_name
  virtual_network_name                          = module.vnet.virtual_network_name
  location                                      = local.location
  subnet_delegations                            = local.subnet_delegation
  service_endpoints                             = local.service_endpoints
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  nsg_id                                        = module.nsg_snet_container.nsg_id
  subnet_rt_association                         = false
}

# ......................................................
# Creation of Private Endpoint Subnet
# ......................................................
module "subnet_pep" {
  source                                        = "../Modules/networking/subnet"
  subnet_name                                   = local.subnet_pep_name
  subnet_address_prefixes                       = var.subnet_pep_address_prefix
  subnet_rg_name                                = module.RG.resource_group_name
  virtual_network_name                          = module.vnet.virtual_network_name
  location                                      = local.location
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.service_endpoints
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  subnet_nsg_association                        = false
  subnet_rt_association                         = false
}

# ......................................................
# Creation of Compute Subnet
# ......................................................
module "subnet_compute" {
  source                                        = "../Modules/networking/subnet"
  subnet_name                                   = local.subnet_compute_name
  subnet_address_prefixes                       = var.subnet_compute_address_prefix
  subnet_rg_name                                = module.RG.resource_group_name
  virtual_network_name                          = module.vnet.virtual_network_name
  location                                      = local.location
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.service_endpoints
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  subnet_nsg_association                        = false
  subnet_rt_association                         = false
}

# ......................................................
# Creation of NSG for Host
# ......................................................
module "nsg_snet_host" {
  source       = "../Modules/networking/networkSecurityGroup"
  nsg_name     = local.nsg_snet_host_name
  nsg_location = local.location
  nsg_rg_name  = module.RG.resource_group_name
  sec_rule = [
    local.default_nsg_rule.databricks_workspace_inbound_wtw,
    local.default_nsg_rule.databricks_workspace_outbound_wtw,
    local.default_nsg_rule.databricks_workspace_outbound_wtsql,
    local.default_nsg_rule.databricks_workspace_outbound_wtstorage,
    local.default_nsg_rule.databricks_workspace_outbound_wteventhub,
  ]
  nsg_tags   = var.nsg_tags
  depends_on = [module.vnet]
}

# ......................................................
# Creation of NSG for Container 
# ......................................................
module "nsg_snet_container" {
  source       = "../Modules/networking/networkSecurityGroup"
  nsg_name     = local.nsg_snet_container_name
  nsg_location = local.location
  nsg_rg_name  = module.RG.resource_group_name
  sec_rule = [
    local.default_nsg_rule.databricks_workspace_inbound_wtw,
    local.default_nsg_rule.databricks_workspace_outbound_wtw,
    local.default_nsg_rule.databricks_workspace_outbound_wtsql,
    local.default_nsg_rule.databricks_workspace_outbound_wtstorage,
    local.default_nsg_rule.databricks_workspace_outbound_wteventhub,
  ]
  nsg_tags   = var.nsg_tags
  depends_on = [module.vnet]
}

# ......................................................
# Creating Private DNS Zone 
# ......................................................
module "private_dns_zone" {
  source                               = "../Modules/networking/privateDNSZone"
  count                                = length(local.private_dns_zone_name)
  private_dns_zone_name                = element(local.private_dns_zone_name, count.index)
  private_dns_zone_resource_group_name = module.RG.resource_group_name
  private_dns_zone_tags                = var.PDZ_tags
  depends_on                           = [module.vnet]
}

# ......................................................
# Creating Private DNS Zone Vnet Link
# ......................................................
module "Vnet_Link" {
  source                                = "../Modules/networking/virtualNetworkLink"
  count                                 = length(local.private_dns_zone_name)
  private_dns_link_name                 = local.Virtual_Network_Link_Name
  private_dns_link_registration_enabled = local.private_dns_link_registration_enabled
  private_dns_link_resource_group_name  = module.RG.resource_group_name
  private_dns_link_virtual_network_id   = module.vnet.virtual_network_id
  private_dns_link_zone_name            = element(local.private_dns_zone_name, count.index)
  private_dns_link_tags                 = var.PDZ_tags
  depends_on                            = [module.private_dns_zone]
}


# Compute Workload
# ......................................................
# Creating Compute for SHIR/SHA
# ......................................................
module "compute" {
  source                 = "../Modules/vm-linux"
  vm_admin_username      = var.vm_admin_username
  vm_machine_size        = var.vm_machine_size
  nic_subnet_id          = module.subnet_compute.subnet_id
  vm_location            = module.RG.resource_group_location
  vm_name                = local.vm_machine_name
  network_interface_name = local.network_interface_name
  vm_os_disk             = local.vm_os_disk
  vm_resource_group_name = module.RG.resource_group_name
  vm_image_reference     = local.vm_image_reference
  vm_public_key          = null
  admin_ssh_key          = null
  admin_password         = var.vm_admin_password
}

# Databricks Workload
# ......................................................
# Creating ADLSGen2 for metastore 
# ......................................................
module "ADLSGen2" {
  source               = "../Modules/adls/storageAccount"
  resource_group_name  = module.RG.resource_group_name
  location             = module.RG.resource_group_location
  storage_account_name = local.storage_account_name
  storage_identity_id  = ["SystemAssigned"]
  network_rule         = var.network_access_adls
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
  databricksAccessConnectorName = "${var.org_name}-${var.bu_name}-dbwaccbg"
  location                      = module.RG.resource_group_location
  rgName                        = module.RG.resource_group_name
  tags                          = var.tags
  storage_account_id            = module.ADLSGen2.storage_account_id
  role_definition_name          = var.role_definition_name
  depends_on                    = [module.ADLSGen2]
}

# ......................................................
# Module: Azure Databricks Workspace
# ......................................................
module "databricksWorkspace" {
  source                      = "../Modules/databricks/databricksWorkspace"
  databricksName              = local.db_name
  resourceGroupName           = module.RG.resource_group_name
  location                    = module.RG.resource_group_location
  databricksNoPublicIp        = true
  databricksPrivateNSGId      = module.nsg_snet_container.nsg_id
  databricksPrivateSubnetName = module.subnet_container.subnet_name
  databricksPublicNSGId       = module.nsg_snet_host.nsg_id
  databricksPublicSubnetName  = module.subnet_host.subnet_name
  databricksVnetId            = module.vnet.virtual_network_id
  databricksSku               = var.databricksWorkspace.sku
  publicNetworkAccessEnabled  = var.publicNetworkAccessEnabled
  tags                        = var.tags
}

# ..........................................................................
# Module: Browser Authentication Private Endpoint for Databricks Workspace
# ..........................................................................
module "databricksBrowsAuthPEP" {
  count                        = var.environment == "transit" ? 1 : 0
  source                       = "../Modules/networking/privateEndpoint"
  peName                       = "${var.org_name}-${var.bu_name}-dbw-browsauth-pe1"
  location                     = module.RG.resource_group_location
  rgName                       = module.RG.resource_group_name
  peSubnetId                   = module.subnet_pep.subnet_id
  peNicName                    = "${var.org_name}-${var.bu_name}-dbw-browsauth-pe1-nic"
  serviceConnectionName        = "${var.org_name}-${var.bu_name}-dbw-browsauth-pe1"
  privateResourceId            = module.databricksWorkspace.databricksWorkspaceId
  subresourceNames             = local.TargetSubresource.dbbrowsAuthPeSubresourceNames
  dnsZoneGroupName             = "${var.org_name}-${var.bu_name}-dbw-browsauth-pe1-dnsgroup"
  privateDnsZoneGroupCondition = true
  privateDnsZoneIds            = module.private_dns_zone[2].private_dns_zone_id

}

# ..........................................................
# Module: UI-API Private Endpoint for Databricks Workspace
# ..........................................................
module "databricksUiApiPEP" {
  source                       = "../Modules/networking/privateEndpoint"
  peName                       = "${var.org_name}-${var.bu_name}-dbw-uiapi-pe1"
  location                     = module.RG.resource_group_location
  rgName                       = module.RG.resource_group_name
  peSubnetId                   = module.subnet_pep.subnet_id
  peNicName                    = "${var.org_name}-${var.bu_name}-dbw-uiapi-pe1-nic"
  serviceConnectionName        = "${var.org_name}-${var.bu_name}-dbw-uiapi-pe1"
  privateResourceId            = module.databricksWorkspace.databricksWorkspaceId
  subresourceNames             = local.TargetSubresource.dbUiApiPeSubresourceNames
  dnsZoneGroupName             = "${var.org_name}-${var.bu_name}-dbw-uiapi-pe1-dnsgroup"
  privateDnsZoneGroupCondition = true
  privateDnsZoneIds            = module.private_dns_zone[2].private_dns_zone_id
}

# ......................................................
# Module: DFS Private Endpoint for Storage Account
# ......................................................
module "adlsGen2DfsPEP" {
  source                       = "../Modules/networking/privateEndpoint"
  peName                       = "${var.org_name}-${var.bu_name}-dls2-dfs-pe1"
  location                     = module.RG.resource_group_location
  rgName                       = module.RG.resource_group_name
  peSubnetId                   = module.subnet_pep.subnet_id
  peNicName                    = "${var.org_name}-${var.bu_name}-dls2-dfs-pe1-nic"
  serviceConnectionName        = "${var.org_name}-${var.bu_name}-dls2-dfs-pe1"
  privateResourceId            = module.ADLSGen2.storage_account_id
  subresourceNames             = local.TargetSubresource.adlsGen2DfsPeSubresourceNames
  dnsZoneGroupName             = "${var.org_name}-${var.bu_name}-dls2-dfs-pe1-dnsgroup"
  privateDnsZoneGroupCondition = true
  privateDnsZoneIds            = module.private_dns_zone[1].private_dns_zone_id

}

# ......................................................
# Module: Blob Private Endpoint for Storage Account
# ......................................................
module "adlsGen2BlobPEP" {
  source                       = "../Modules/networking/privateEndpoint"
  peName                       = "${var.org_name}-${var.bu_name}-dls2-blob-pe1"
  location                     = module.RG.resource_group_location
  rgName                       = module.RG.resource_group_name
  peSubnetId                   = module.subnet_pep.subnet_id
  peNicName                    = "${var.org_name}-${var.bu_name}-dls2-blob-pe1-nic"
  serviceConnectionName        = "${var.org_name}-${var.bu_name}-dls2-blob-pe1"
  privateResourceId            = module.ADLSGen2.storage_account_id
  subresourceNames             = local.TargetSubresource.adlsGen2BlobPeSubresourceNames
  dnsZoneGroupName             = "${var.org_name}-${var.bu_name}-dls2-blob-pe1-dnsgroup"
  privateDnsZoneGroupCondition = true
  privateDnsZoneIds            = module.private_dns_zone[0].private_dns_zone_id
}

# Metastore Workload
# Module to create the Databricks metastore.
module "metastore_creation" {
  count            = var.environment == "transit" ? 1 : 0
  source           = "../Modules/databricks/databricks-metastore-creation"
  metastore_name   = var.metastore_region
  metastore_region = var.metastore_region
  adls_name        = format("abfss://%s@%s.dfs.core.windows.net/", local.container_name, local.storage_account_name)
  acc_name         = module.databricksAccessConnector.access_id
}

# Module to assign the created metastore to the Databricks workspaces.
module "metastore_workspace_assignment" {
  source        = "../Modules/databricks/databricks-metastore-workspace-assignment"
  metastore_id  = module.metastore_creation[0].metastore_id
  workspace_ids = local.workspace_ids
}
