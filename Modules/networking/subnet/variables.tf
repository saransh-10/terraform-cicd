variable "subnet_name" {
  type        = string
  description = "subnet name for new subnet"
}
variable "subnet_rg_name" {
  type        = string
  description = "The name of the Azure Resource Group where the Subnet will be created."
}
variable "subnet_address_prefixes" {
  type        = list(string)
  description = "The address prefixes for the Azure Compute Subnet."
}
variable "virtual_network_name" {
  type        = string
  description = "The name of the Azure Virtual Network where the Subnet will be created."
}
variable "private_link_service_network_policies_enabled" {
  type        = bool
  description = "Indicates whether network policies are enabled for private link service on this subnet."
}
variable "subnet_delegations" {
  type        = any
  nullable    = true
  default     = {}
  description = "Object of subnet delegations for the Azure Subnet."
}
variable "nsg_id" {
  type        = string
  default     = ""
  description = "network security group id to associate subnet with."
}
variable "subnet_nsg_association" {
  type        = bool
  default     = true
  description = "subnet nsg assocation bool: defaults to true"
}
variable "subnet_rt_association" {
  type        = bool
  default     = true
  description = "subnet rt assocation bool: defaults to true"
}
variable "virtual_network_location" {
  type        = string
  description = "The location (region) where the Azure Virtual Network will be created."
}
variable "routeTableName" {
  description = "Creation of Route Table"
  type = string
}
