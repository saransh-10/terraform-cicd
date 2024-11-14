# Variable to define the address space for the virtual network
variable "address_space_vnet" {
  type        = list(string)
  description = "The address space for the virtual network."
}
# Variable to define tags for the virtual network
variable "vnet_tags" {
  type        = map(string)
  description = "A map of tags to assign to the virtual network."
}
# Variable to define the address prefixes for compute subnet
variable "subnet_compute_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the compute subnet."
  default     = [""]
}
# Variable to define tags for the network security groups
variable "nsg_tags" {
  type        = map(string)
  description = "A map of tags to assign to the network security groups."
}
# Variable to define subnet routetable association
variable "subnet_routetable_association" {
  type        = bool
  description = "Route table association True if want to associate route table to subnet else false"
}
# Variable for the organization name
variable "org_name" {
  type        = string
  description = "The name of the organization."
}
# Variable for the business unit name
variable "bu_name" {
  type        = string
  description = "The name of the business unit."
}
# Variable for the environment name
# variable "environment" {
#   type        = string
#   description = "The name of the environment."
# }
# Compute Variables
variable "vm_machine_size" {
  type        = string
  description = "Virtual machine Size"
}
variable "vm_admin_username" {
  type        = string
  description = "Virtual Machine Admin Username"
}
variable "vm_admin_password" {
  type        = string
  description = "Virtual Machine Admin Password"
}