locals {
  # Names
  resource_group_name = lower("${var.org_name}-${var.bu_name}-net-rg-01")
  # Vnet_name
  virtual_network_name = lower("${var.org_name}-${var.bu_name}-vnet-01")
  # Subnet_name
  subnet_compute_name = lower("${var.org_name}-${var.bu_name}-snet-compute-01")
  #NSG
  nsg_compute_name = "VMAccessNSG"
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
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    vm_access_Inbound = {
      name                       = "VMAccess_Outbound"
      priority                   = 101
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
  # Compute Locals
  # nsg_compute_name = lower("${var.org_name}-${var.bu_name}-nsg-compute-01")
  vm_os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  vm_machine_name        = lower("${var.org_name}-${var.bu_name}-compute-01")
  network_interface_name = lower("${var.org_name}-${var.bu_name}-nic-compute-01")
  # nic_private_ip_address_allocation = "Dynamic"
  vm_image_reference = {
    sku       = "22_04-lts"
    version   = "latest"
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
  }
}
