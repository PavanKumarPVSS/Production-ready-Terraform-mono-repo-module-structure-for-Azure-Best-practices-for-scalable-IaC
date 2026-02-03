# Storage Account Outputs
output "storage_account_id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.tfstate.id
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.tfstate.name
}

# VNet Outputs
output "vnet_id" {
  description = "ID of the Databricks VNet"
  value       = module.databricks_vnet.vnet_id
}

output "vnet_name" {
  description = "Name of the Databricks VNet"
  value       = module.databricks_vnet.vnet_name
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.databricks_vnet.public_subnet_id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = module.databricks_vnet.private_subnet_id
}

# Databricks Workspace Outputs
output "databricks_workspace_id" {
  description = "ID of the Databricks workspace"
  value       = module.databricks_workspace.workspace_id
}

output "databricks_workspace_url" {
  description = "URL of the Databricks workspace"
  value       = module.databricks_workspace.workspace_url
}

output "databricks_workspace_name" {
  description = "Name of the Databricks workspace"
  value       = module.databricks_workspace.workspace_name
}

output "databricks_managed_resource_group_id" {
  description = "ID of the managed resource group"
  value       = module.databricks_workspace.managed_resource_group_id
}

# Unity Catalog Outputs
output "unity_catalog_access_connector_id" {
  description = "ID of the Unity Catalog Access Connector"
  value       = module.unity_catalog.access_connector_id
}

output "unity_catalog_storage_account_name" {
  description = "Name of the Unity Catalog storage account"
  value       = module.unity_catalog.storage_account_name
}

output "unity_catalog_metastore_storage_path" {
  description = "Storage path for Unity Catalog metastore"
  value       = module.unity_catalog.metastore_storage_path
}

output "unity_catalog_principal_id" {
  description = "Principal ID of the Access Connector for Unity Catalog"
  value       = module.unity_catalog.access_connector_principal_id
}
