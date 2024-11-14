# ......................................................
# Creating New Resource Group
# ......................................................
module "RG" {
  source                  = "../Modules/rg"
  resource_group_name     = local.resource_group_name
  resource_group_location = local.location
}
# ......................................................
# Creating New Virtual Network
# ......................................................
module "vnet" {
  source                        = "../Modules/networking/virtualNetwork"
  new_virtual_network_name      = local.virtual_network_name
  virtual_network_location      = local.location
  virtual_network_address_space = local.address_space_vnet
  resource_group_name           = module.RG.resource_group_name
  virtual_network_tags          = var.vnet_tags
}
# ......................................................
# Creation of NSG for Host
# ......................................................
module "nsg_compute" {
  source       = "../Modules/networking/networkSecurityGroup"
  nsg_name     = local.nsg_compute_name
  nsg_location = local.location
  nsg_rg_name  = module.RG.resource_group_name
  sec_rule = [
    local.default_nsg_rule.vm_access_Inbound,
    local.default_nsg_rule.vm_access_Outbound
  ]
  nsg_tags   = var.nsg_tags
  depends_on = [module.vnet]
}
# ......................................................
# Creation of Compute Subnet
# ......................................................
module "subnet_compute" {
  source                                        = "../Modules/networking/subnet"
  subnet_name                                   = local.subnet_compute_name
  subnet_address_prefixes                       = var.subnet_compute_address_prefix
  subnet_rg_name                                = module.RG.resource_group_name
  virtual_network_name                          = module.vnet.virtual_network_name
  subnet_delegations                            = local.subnet_delegation_null
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  nsg_id                                        = module.nsg_compute.nsg_id
  subnet_rt_association                         = var.subnet_routetable_association
  depends_on                                    = [module.nsg_compute]
}
# Compute Workload
# ......................................................
# Creating Compute for SHIR/SHA only for Transit RG
# ......................................................
module "compute" {
  source                 = "../Modules/vm-linux"
  vm_admin_username      = var.vm_admin_username
  vm_machine_size        = var.vm_machine_size
  nic_subnet_id          = module.subnet_compute.subnet_id
  vm_location            = module.RG.resource_group_location
  vm_name                = local.vm_machine_name
  network_interface_name = local.network_interface_name
  vm_os_disk             = local.vm_os_disk
  vm_resource_group_name = module.RG.resource_group_name
  vm_image_reference     = local.vm_image_reference
  vm_public_key          = null
  admin_ssh_key          = null
  admin_password         = var.vm_admin_password
}
