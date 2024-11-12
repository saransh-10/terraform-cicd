terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.50.0"
    }
  }
}
resource "databricks_metastore" "metastore-creation" {
  name          = var.metastore_name
  region        = var.metastore_region
  storage_root  = var.adls_name
  force_destroy = true
}

resource "databricks_metastore_data_access" "access" {
  metastore_id = databricks_metastore.metastore-creation.id
  name         = "mi_dac"
  azure_managed_identity {
    access_connector_id = var.acc_name
  }
  is_default = true
  depends_on = [databricks_metastore.metastore-creation]
}
