variable "private_dns_zone_name" {
  description = "Name of the Private DNS zone"
  type        = string
}

variable "private_dns_zone_resource_group_name" {
  description = "Name of the resource group containing the Private DNS zone"
  type        = string
}

variable "private_dns_zone_tags" {
  description = "Tags for the Private DNS zone"
  type        = map(string)
}

