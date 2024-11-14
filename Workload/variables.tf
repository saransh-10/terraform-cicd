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
# Variable to define the address prefixes for host subnet
variable "subnet_host_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the host subnet."
}
# Variable to define the address prefixes for Container subnet
variable "subnet_container_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the container subnet."
}
# Variable to define the address prefixes for private endpoint subnet
variable "subnet_pep_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the private endpoint subnet."
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
variable "environment" {
  type        = string
  description = "The name of the environment."
}
# Variable for the tags for Private DNS Zone
variable "PDZ_tags" {
  type        = map(string)
  description = "Tags for Private DNS Zone"
}
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
# Databricks Variables
# Variable for public access for the databricks workspace
variable "publicNetworkAccessEnabled" {
  type        = bool
  description = "True or False for public access to the workspace"
}
# Variable for SKU for the workspace
variable "databricksWorkspace" {
  type = object({
    sku = string
  })
  description = "Premium or Standard"
}
# Variable for the tags
variable "tags" {
  type        = map(string)
  description = "Tags for access connector."
}
# Variables of ADLS Workload
variable "role_definition_name" {
  type        = string
  description = "Role required Ex Storage Blob Data Contributor"
}
# Variable for container_access_type
variable "container_access_type" {
  description = " (Optional) The Access Level configured for this Container. Possible values are blob, container or private. Defaults to private."
  type        = string
}
# Variable for public access
variable "network_access_adls" {
  type        = bool
  description = "True to enable Public access otherwise False"
}
# Metastore Varaibles
# For databricks autheenction service principal
variable "databricks_host_name" {
  description = "Databricks host URL for authentication"
  type        = string
  default     = "https://accounts.azuredatabricks.net/"
  validation {
    condition     = startswith(var.databricks_host_name, "https://")
    error_message = "[databricks_host_name] must start with 'https://'"
  }
}
variable "databricks_account_id" {
  description = "Databricks account ID for the service principal"
  type        = string
  default     = ""
  validation {
    condition     = length(var.databricks_account_id) > 0
    error_message = "[databricks_account_id] must not be empty"
  }
}
# metastore configuration details.
variable "metastore_region" {
  description = "Region for the Databricks metastore configuration"
  type        = string
  default     = ""
  validation {
    condition     = length(var.metastore_region) > 0
    error_message = "[metastore_region] must not be empty"
  }
}
