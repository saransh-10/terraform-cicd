data "databricks_metastores" "all" {
  count = var.environment == "transit" ? 0 : 1
}

resource "random_uuid" "uuid" {}
locals {
  secret_value = join("", ["KV", random_uuid.uuid.result])
}
