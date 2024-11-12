variable "private_dns_link_name" {
  description = "Name of the Private DNS zone virtual network link"
  type        = string
}

variable "private_dns_link_registration_enabled" {
  description = "Boolean flag indicating whether registration is enabled for the Private DNS zone virtual network link"
  type        = bool
}

variable "private_dns_link_resource_group_name" {
  description = "Name of the resource group containing the Private DNS zone"
  type        = string
}

variable "private_dns_link_zone_name" {
  description = "Name of the Private DNS zone"
  type        = string
}

variable "private_dns_link_virtual_network_id" {
  description = "ID of the virtual network to link with the Private DNS zone"
  type        = string
}

variable "private_dns_link_tags" {
  description = "Tags for the Private DNS zone virtual network link"
  type        = map(string)
}
