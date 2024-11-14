address_space_vnet = ["10.10.0.0/16"]
vnet_tags = {
  "owner" = "orica"
}
subnet_compute_address_prefix = ["10.10.0.0/24"]
nsg_tags = {
  "owner" = "orica"
}
org_name = "orica"
bu_name  = "vm"
# environment                   = "vm"
subnet_routetable_association = false
# Compute
vm_machine_size   = "Standard_D4s_v4"
vm_admin_username = "admintest"
vm_admin_password = "Password@123"
