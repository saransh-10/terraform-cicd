terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.50.0"
    }
  }
}
resource "databricks_metastore_assignment" "metastore-workspace-assignment" {
  for_each     = toset(var.workspace_ids)
  metastore_id = var.metastore_id
  workspace_id = each.key
}


