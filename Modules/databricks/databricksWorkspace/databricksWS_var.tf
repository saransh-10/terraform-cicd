variable "databricksName" {
  description = "Name of the Databricks Workspace."
  type        = string
}

variable "resourceGroupName" {
  type = string
  description = "The name of the Azure Resource Group where the Logic App will be created."
}

variable "location" {
  type = string
  description = "The location (region) where the Logic App will be created."
}

variable "databricksNoPublicIp" {
  type = bool
  description = "Are public IP Addresses not allowed? Possible values are true or false. Defaults to false"
}

variable "databricksPublicSubnetName" {
  type = string
  description = "The name of the Public Subnet within the Virtual Network. Required if virtual_network_id is set."
}

variable "databricksPrivateSubnetName" {
  type = string
  description = "The name of the Private Subnet within the Virtual Network. Required if virtual_network_id is set. "
}

variable "databricksSku" {
  type = string
  description = "The sku to use for the Databricks Workspace. Possible values are standard, premium, or trial."
}

variable "databricksVnetId" {
  type = string
  description = "The ID of a Virtual Network where this Databricks Cluster should be created."
}

variable "databricksPublicNSGId" {
  type = string
  description = "The resource ID of the azurerm_subnet_network_security_group_association resource which is referred to by the public_subnet_name field. This is the same as the ID of the subnet referred to by the public_subnet_name field. Required if virtual_network_id is set."
}

variable "databricksPrivateNSGId" {
  type = string
  description = "The resource ID of the azurerm_subnet_network_security_group_association resource which is referred to by the private_subnet_name field. This is the same as the ID of the subnet referred to by the private_subnet_name field. Required if virtual_network_id is set."
}

variable "publicNetworkAccessEnabled" {
  type = string
  description = "Allow public access for accessing workspace. Set value to false to access workspace only via private link endpoint. Possible values include true or false. Defaults to true."
}

variable "tags" {
  description = "A map of tags to assign to the Azure Databricks Workspace."
  type        = map(string)

}