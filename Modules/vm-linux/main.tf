# Creates a network interface with the specified name, location, and resource group, along with an IP configuration that includes the subnet ID and private IP address allocation method.
resource "azurerm_network_interface" "vm_nic" {
  name                = var.network_interface_name
  location            = var.vm_location
  resource_group_name = var.vm_resource_group_name

  # Defines an IP configuration for the network interface, specifying the configuration name, subnet ID, and method for allocating private IP addresses.
  ip_configuration {
    name                          = var.nic_ip_configuration_name
    subnet_id                     = var.nic_subnet_id
    private_ip_address_allocation = var.nic_private_ip_address_allocation
  }
  
}

# This Terraform block defines an Azure Linux virtual machine with specified parameters.
resource "azurerm_linux_virtual_machine" "virtual_machine" {
  name                            = var.vm_name
  resource_group_name             = var.vm_resource_group_name
  location                        = var.vm_location
  size                            = var.vm_machine_size
  admin_username                  = var.vm_admin_username
  network_interface_ids           = [azurerm_network_interface.vm_nic.id]
  # source_image_id                 = var.source_image_id
  computer_name                   = var.vm_admin_username
  admin_password                  = var.admin_ssh_key != null ? null : var.admin_password
  disable_password_authentication = var.admin_ssh_key != null ? true : false

  # This dynamic block adds an SSH key for admin access to the Azure Linux virtual machine, if provided.
  dynamic "admin_ssh_key" {
    for_each = var.admin_ssh_key != null ? [1] : []
    content {
      username   = var.vm_admin_username
      public_key = var.vm_public_key
    }
  }

  # This block configures the operating system disk for the Azure Linux virtual machine with specified caching and storage account type.
  os_disk {
    caching              = var.vm_os_disk.caching
    storage_account_type = var.vm_os_disk.storage_account_type
  }

  # This dynamic block defines the source image reference for the Azure Linux virtual machine, based on provided image parameters if the source image ID is not specified.
  source_image_reference {
      sku       = var.vm_image_reference.sku
      version   = var.vm_image_reference.version
      publisher = var.vm_image_reference.publisher
      offer     = var.vm_image_reference.offer
  }
}
