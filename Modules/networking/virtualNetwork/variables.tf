variable "new_virtual_network_name" {
  type = string
  description = "The name for the new Azure Virtual Network."
}

variable "virtual_network_location" {
  type        = string
  description = "The location (region) where the Azure Virtual Network will be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Azure Resource Group where the Virtual Network will be created."
}
 
variable "virtual_network_address_space" {
  type        = list(string)
  description = "The address space of the Azure Virtual Network."
}
 
variable "virtual_network_tags" {
  type        = map(string)
  description = "A map of tags to apply to the Azure Virtual Network."
}