variable "network_interface_name" {
  description = "Name of the network interface"
  type        = string
}

# variable "network_interface_location" {
#   description = "Location of the network interface"
#   type        = string
# }

# variable "network_interface_resource_group_name" {
#   description = "Name of the resource group containing the network interface"
#   type        = string
# }

variable "nic_ip_configuration_name" {
  description = "Name of the IP configuration"
  type        = string
  default = "internal"
}

variable "nic_subnet_id" {
  description = "ID of the subnet to associate with the IP configuration"
  type        = string
}

variable "nic_private_ip_address_allocation" {
  description = "Method to allocate the private IP address (Dynamic or Static)"
  type        = string
  default = "Dynamic"
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "vm_resource_group_name" {
  description = "Name of the resource group containing the virtual machine"
  type        = string
}

variable "vm_location" {
  description = "Location of the virtual machine"
  type        = string
}

variable "vm_machine_size" {
  description = "Size of the virtual machine"
  type        = string
}

variable "vm_admin_username" {
  description = "Admin username for the virtual machine"
  type        = string
}


variable "admin_ssh_key" {
  description = "Path of the key which will be use in authentication."
  type        = string
}

variable "admin_password" {
  description = "If we don't use, we will do authentication with password."
  type        = string
  sensitive   = true
}

# variable "source_image_id" {
#   description = "The ID of the source image to be used for the virtual machine."
#   type        = string
# }

variable "vm_public_key" {
  description = "The public SSH key to be used for authentication to the virtual machine."
  type        = string
}


variable "vm_os_disk" {
  description = "Configuration for the virtual machine's OS disk"
  type = object({
    caching              = string
    storage_account_type = string
  })
}

variable "vm_image_reference" {
  description = "Image reference for the virtual machine"
  type = object({
    sku       = string
    version   = string
    publisher = string
    offer     = string
  })
}
