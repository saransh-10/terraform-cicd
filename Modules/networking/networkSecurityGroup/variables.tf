variable "nsg_name" {
  type = string
  description = "nsg name"
}

variable "nsg_location" {
  type        = string
  description = "The location (region) where the Azure Network Security Group will be created."
}

variable "nsg_rg_name" {
  type        = string
  description = "The name of the Azure Resource Group where the Network Security Group will be created."
}

variable "nsg_tags" {
  type        = map(string)
  description = "A map of tags to apply to the Azure Network Security Group."
}


variable "sec_rule" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string  
    access                     = string  
    protocol                   = string 
    source_port_range          = string #                    `json:"destinationPortRange,omitempty"`
    destination_port_range     = string  
    source_address_prefix      = string  
    destination_address_prefix = string  
  }))
  description = "nsg rule with attributes."
}
