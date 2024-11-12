variable "metastore_id" {
  type        = string
  description = "Unique identifier of the parent Metastore"
}
variable "workspace_ids" {
  type        = any
  description = "List of Ids of the workspaces for the assignment to the metastore"
}

