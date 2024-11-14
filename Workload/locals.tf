locals {
  # Names
  resource_group_name = lower("${var.org_name}-${var.bu_name}-net-rg-01")
  # Vnet_name
  virtual_network_name = lower("${var.org_name}-${var.bu_name}-vnet-01")
  # NSG_name
  nsg_snet_host_name      = lower("${var.org_name}-${var.bu_name}-nsg-host-01")
  nsg_snet_container_name = lower("${var.org_name}-${var.bu_name}-nsg-container-01")
  # Vnet_Link_name
  Virtual_Network_Link_Name = "Orica_PDZ_VNET_Link"
  # Subnet_name
  subnet_host_name      = lower("${var.org_name}-${var.bu_name}-host-snet-01")
  subnet_container_name = lower("${var.org_name}-${var.bu_name}-container-snet-01")
  subnet_pep_name       = lower("${var.org_name}-${var.bu_name}-snet-pep-01")
  subnet_compute_name   = lower("${var.org_name}-${var.bu_name}-snet-compute-01")
  # Privat DNS Zone 
  private_dns_zone_name = [
    "privatelink.blob.core.windows.net",
    "privatelink.dfs.core.windows.net",
    "privatelink.azuredatabricks.net",
  ]
  # Location
  location = lower("centralus")
  # Address Space for Virtual network
  address_space_vnet = var.address_space_vnet
  # Subnets private endpoint network policy enabled or disabled(enabled in case of subnet stores private endpoints)
  # subnet_private_endpoint_network_policy_false = false
  # subnet_private_endpoint_network_policy_true  = true
  # Subnet deligations 
  subnet_delegation = {
    subnet_delegation_name  = "databricks-del-public"
    service_delegation_name = "Microsoft.Databricks/workspaces"
    actions = [
      "Microsoft.Network/virtualNetworks/subnets/action",
      "Microsoft.Network/virtualNetworks/subnets/join/action",
      "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"
    ]
  }
  subnet_delegation_null = {}
  # Private DNS Zone
  private_dns_link_registration_enabled = false
  # subnet private link service network policies enabled or disabled
  # private_link_service_network_policies_enabled_true  = true
  private_link_service_network_policies_enabled_false = false
  ## disable bgp route propagation
  # disable_bgp_route_propagation = true
  # enable_bgp_route_propagation  = false
  # Service endpoints 
  service_endpoints = toset([
    "Microsoft.Storage",
    "Microsoft.AzureActiveDirectory",
    "Microsoft.Sql"
  ])
  # Nsg details
  default_nsg_rule = {
    databricks_workspace_inbound_wtw = {
      name                       = "Ms.Databricks-workspace_worker-to-worker-inbound"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "VirtualNetwork"
    },
    databricks_workspace_outbound_wtw = {
      name                       = "Ms.Databricks-workspace_worker-to-worker-outbound"
      priority                   = 100
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "VirtualNetwork"
    },
    databricks_workspace_outbound_wtsql = {
      name                       = "Ms.Databricks-workspace_worker-to-sql-outbound"
      priority                   = 101
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "3306"
      destination_port_range     = "*"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "Sql"
    },
    databricks_workspace_outbound_wtstorage = {
      name                       = "Ms.Databricks-workspace_worker-to-storage-outbound"
      priority                   = 102
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "443"
      destination_port_range     = "*"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "Storage"
    },
    databricks_workspace_outbound_wteventhub = {
      name                       = "Ms.Databricks-workspace_worker-to-eventhub-outbound"
      priority                   = 103
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "9093"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "EventHub"
    }
  }
  # Compute Locals
  # nsg_compute_name = lower("${var.org_name}-${var.bu_name}-nsg-compute-01")
  vm_os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  vm_machine_name                   = lower("${var.org_name}-${var.bu_name}-compute-01")
  network_interface_name            = lower("${var.org_name}-${var.bu_name}-nic-compute-01")
  # nic_private_ip_address_allocation = "Dynamic"
  vm_image_reference = {
    sku       = "22_04-lts"
    version   = "latest"
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
  }
  # Databricks Locals
  storage_account_name             = lower("${var.org_name}${var.bu_name}dls201")
  storage_container_metastore_name = lower("metastore")
  storage_container_ext_name       = lower("external")
  access_connector_name            = "${var.org_name}-${var.bu_name}-dbwaccbg"
  db_name                          = "${var.org_name}-${var.bu_name}-dbwbg"
  TargetSubresource = {
    adlsGen2BlobPeSubresourceNames = ["blob"]
    adlsGen2DfsPeSubresourceNames  = ["dfs"]
    dbbrowsAuthPeSubresourceNames  = ["browser_authentication"]
    dbUiApiPeSubresourceNames      = ["databricks_ui_api"]
  }
  # Private Endpoints
  # Brows Auth
  db_browsauth_pe_name           = "${var.org_name}-${var.bu_name}-dbw-browsauth-pe1"
  db_browsauth_pe_nic_name       = "${var.org_name}-${var.bu_name}-dbw-browsauth-pe1-nic"
  db_browsauth_pe_service_name   = "${var.org_name}-${var.bu_name}-dbw-browsauth-pe1"
  db_browsauth_pe_dns_group_name = "${var.org_name}-${var.bu_name}-dbw-browsauth-pe1-dnsgroup"
  # UiApi
  db_uiapi_pe_name           = "${var.org_name}-${var.bu_name}-dbw-uiapi-pe1"
  db_uiapi_pe_nic_name       = "${var.org_name}-${var.bu_name}-dbw-uiapi-pe1-nic"
  db_uiapi_pe_service_name   = "${var.org_name}-${var.bu_name}-dbw-uiapi-pe1"
  db_uiapi_pe_dns_group_name = "${var.org_name}-${var.bu_name}-dbw-uiapi-pe1-dnsgroup"
  # Blob
  adls_blob_pe_name           = "${var.org_name}-${var.bu_name}-dls2-blob-pe1"
  adls_blob_pe_nic_name       = "${var.org_name}-${var.bu_name}-dls2-blob-pe1-nic"
  adls_blob_pe_service_name   = "${var.org_name}-${var.bu_name}-dls2-blob-pe1"
  adls_blob_pe_dns_group_name = "${var.org_name}-${var.bu_name}-dls2-blob-pe1-dnsgroup"
  # DFS
  adls_dfs_pe_name           = "${var.org_name}-${var.bu_name}-dls2-dfs-pe1"
  adls_dfs_pe_nic_name       = "${var.org_name}-${var.bu_name}-dls2-dfs-pe1-nic"
  adls_dfs_pe_service_name   = "${var.org_name}-${var.bu_name}-dls2-dfs-pe1"
  adls_dfs_pe_dns_group_name = "${var.org_name}-${var.bu_name}-dls2-dfs-pe1-dnsgroup"
  # Metastore Locals
  metastore_name                   = var.metastore_region
  container_name                   = local.storage_container_metastore_name
  metastore_storage_container_name = format("abfss://%s@%s.dfs.core.windows.net/", local.container_name, local.storage_account_name)
}