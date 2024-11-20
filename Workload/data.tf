data "databricks_metastores" "all" {
  count = var.environment == "transit" ? 0 : 1
}
