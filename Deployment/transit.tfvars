address_space_vnet = ["10.10.0.0/16"]
vnet_tags = {
  "owner" = "orica"
}
subnet_compute_address_prefix = ["10.10.0.0/27"]
nsg_tags = {
  "owner" = "orica"
}
#org_name = "orica"
bu_name  = "transit"
# environment                   = "vm"
subnet_routetable_association = false
# Compute
vm_machine_size   = "Standard_D4s_v4"
vm_admin_username = "admin"
vm_admin_password = "bCA!9/5yy(4p"
