resource "azurerm_databricks_workspace" "databricks" {
  name                                  = var.databricksName
  resource_group_name                   = var.resourceGroupName
  location                              = var.location
  sku                                   = var.databricksSku
  public_network_access_enabled         = var.publicNetworkAccessEnabled
  network_security_group_rules_required = "NoAzureDatabricksRules"
  custom_parameters {
    no_public_ip                                         = var.databricksNoPublicIp
    public_subnet_name                                   = var.databricksPublicSubnetName
    private_subnet_name                                  = var.databricksPrivateSubnetName
    virtual_network_id                                   = var.databricksVnetId
    public_subnet_network_security_group_association_id  = var.databricksPublicNSGId
    private_subnet_network_security_group_association_id = var.databricksPrivateNSGId
  }
  tags = var.tags 
}


