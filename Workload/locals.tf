locals {
  # Names
  resource_group_name = lower("rg-${var.bu_name}-centralus-01")
  # Vnet_name
  virtual_network_name = lower("vnet-${var.bu_name}-centralus-01")
  # Subnet_name
  subnet_compute_name = lower("compute-snet-${var.bu_name}-centralus-01")
  #NSG
  nsg_compute_name = lower("compute-nsg-${var.bu_name}-centralus-01")
  # Location
  location = lower("centralus")
  # Address Space for Virtual network
  address_space_vnet = var.address_space_vnet
  # Subnet deligations
  subnet_delegation_null = {}
  # Private Link
  private_link_service_network_policies_enabled_false = false
  # Service Endpoints
  # Nsg details
  default_nsg_rule = {
    vm_access_Outbound = {
      name                       = "VMAccess_Inbound"
      priority                   = 100
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "22"
      destination_port_range     = "*"
      source_address_prefix      = "10.10.0.0/16"
      destination_address_prefix = "AzureCloud"
    },
    vm_access_Inbound = {
      name                       = "VMAccess_Outbound"
      priority                   = 101
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "AzureCloud"
      destination_address_prefix = "10.10.0.0/16"
    }
  }
  # Compute Locals
  # nsg_compute_name = lower("${var.org_name}-${var.bu_name}-nsg-compute-01")
  vm_os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  vm_machine_name        = lower("vm-compute-${var.bu_name}-centralus-01")
  network_interface_name = lower("vm-nic-${var.bu_name}-centralus-01")
  # nic_private_ip_address_allocation = "Dynamic"
  vm_image_reference = {
    sku       = "22_04-lts"
    version   = "latest"
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
  }
}
