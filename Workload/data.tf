data "databricks_metastores" "all" {
  count = var.environment == "transit" ? 0 : 1
}
data "azurerm_resource_group" "NetworkRG" {
  name = local.Resource_Group_Name
}
data "azurerm_resource_group" "AppRG" {
  name = local.Resource_Group_appName
}
data "azurerm_virtual_network" "NetworkVNet" {
  resource_group_name = local.Resource_Group_Name
  name                = local.VNet_Name
}
