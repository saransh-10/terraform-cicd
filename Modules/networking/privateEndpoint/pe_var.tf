variable "peName" {
  description = "The name of the Azure Private Endpoint."
  type        = string
}

variable "location" {
  description = "The Azure region where the Private Endpoint will be created."
  type        = string
}

variable "rgName" {
  description = "The name of the resource group in which to create the Azure Private Endpoint."
  type        = string
}

variable "peSubnetId" {
  description = "The ID of the subnet in which to place the Private Endpoint."
  type        = string
}

variable "serviceConnectionName" {
  description = "The name of the private service connection associated with the Private Endpoint."
  type        = string
}

variable "privateResourceId" {
  description = "The resource ID of the private resource to connect to."
  type        = string
}

variable "subresourceNames" {
  description = "A list of subresource names associated with the private connection."
  type        = list(string)
}

variable "peNicName" {
  type        = string
  description = "a string value for private endpoint network interface name"
}

variable "isManualConnection" {
  description = "A boolean flag indicating whether the service connection is manual or not."
  type        = bool
  default = false
}

variable "privateDnsZoneIds" {
  description = "A list of private DNS zones associated with the Private Endpoint."
  type        = string
}


variable "dnsZoneGroupName" {
  type        = string
  description = "A string value for private dns zone group name for private endpoint."
}

variable "privateDnsZoneGroupCondition" {
  type = bool
  description = "Condition for Private DNS Zone integration."
}