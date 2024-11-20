resource "random_uuid" "uuid" {}
locals {
  # Names
  resource_group_name = "rg-databricks-test-westus2-01"
  # Vnet_name
  virtual_network_name = "vnet-databricks-test-westus2-01"
  # NSG_name
  nsg_snet_host_name      = "nsg-host-test-westus2-01"
  nsg_snet_container_name = "nsg-container-test-westus2-01"
  # Vnet_Link_name
  Virtual_Network_Link_Name = "vnet-link-test-westus2-01"
  # Subnet_name
  subnet_host_name      = "snet-host-test-01"
  subnet_container_name = "snet-container-test-westus2-01"
  subnet_pep_name       = "snet-pe-test-westus2-01"
  # Privat DNS Zone
  private_dns_zone_name = [
    "privatelink.blob.core.windows.net",
    "privatelink.dfs.core.windows.net",
    "privatelink.azuredatabricks.net",
  ]
  # Location
  location = lower("westus2")
  # Address Space for Virtual network
  address_space_vnet = var.address_space_vnet
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
  # Compute Locals
  nsg_compute_name = "nsg-nic-shr-test-westus2-01"
  vm_os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 128
  }
  vm_machine_name        = "vm-shr-test-westus2-01"
  vm_admin_password      = random_uuid.uuid.result
  network_interface_name = "nic-shr-test-westus2-01"
  # nic_private_ip_address_allocation = "Dynamic"
  vm_image_reference = {
    sku       = "22_04-lts"
    version   = "latest"
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
  }
  # Databricks Locals
  storage_account_name             = "stdbwmetatestwus201"
  storage_container_metastore_name = lower("metastore-test-westus2-01")
  storage_container_ext_name       = lower("external-location-test-westus2-01")
  access_connector_name            = "dbacc-test-westus2-01"
  db_name                          = "dbw-test-westus2-01"
  TargetSubresource = {
    adlsGen2BlobPeSubresourceNames = ["blob"]
    adlsGen2DfsPeSubresourceNames  = ["dfs"]
    dbbrowsAuthPeSubresourceNames  = ["browser_authentication"]
    dbUiApiPeSubresourceNames      = ["databricks_ui_api"]
  }
  # Private Endpoints
  # Brows Auth
  db_browsauth_pe_name           = "pe-dbw-browsauth-test-westus2-01"
  db_browsauth_pe_nic_name       = "pe-dbw-browsauth-nic-test-westus2-01"
  db_browsauth_pe_service_name   = "pe-dbw-browsauth-svc-test-westus2-01"
  db_browsauth_pe_dns_group_name = "pe-dbw-browsauth-dnsgroup-test-westus2-01"
  # UiApi
  db_uiapi_pe_name           = "pe-dbw-uiapi-test-westus2-01"
  db_uiapi_pe_nic_name       = "pe-dbw-uiapi-nic-test-westus2-01"
  db_uiapi_pe_service_name   = "pe-dbw-uiapi-svc-test-westus2-01"
  db_uiapi_pe_dns_group_name = "pe-dbw-uiapi-dnsgroup-test-westus2-01"
  # Blob
  adls_blob_pe_name           = "pe-st-blob-test-westus2-01"
  adls_blob_pe_nic_name       = "pe-st-blob-nic-test-westus2-01"
  adls_blob_pe_service_name   = "pe-st-blob-svc-test-westus2-01"
  adls_blob_pe_dns_group_name = "pe-st-blob-dnsgroup-test-westus2-01"
  # DFS
  adls_dfs_pe_name           = "pe-st-dfs-test-westus2-01"
  adls_dfs_pe_nic_name       = "pe-st-dfs-nic-test-westus2-01"
  adls_dfs_pe_service_name   = "pe-st-dfs-svc-test-westus2-01"
  adls_dfs_pe_dns_group_name = "pe-st-dfs-dnsgroup-test-westus2-01"
  # Metastore Locals
  metastore_name                   = var.metastore_region
  container_name                   = local.storage_container_metastore_name
  metastore_storage_container_name = format("abfss://%s@%s.dfs.core.windows.net/", local.container_name, local.storage_account_name)
}
