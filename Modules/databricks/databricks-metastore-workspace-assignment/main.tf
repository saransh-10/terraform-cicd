terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.50.0"
    }
  }
}
resource "databricks_metastore_assignment" "metastore-workspace-assignment" {
  metastore_id = var.metastore_id
  workspace_id = var.workspace_ids
}