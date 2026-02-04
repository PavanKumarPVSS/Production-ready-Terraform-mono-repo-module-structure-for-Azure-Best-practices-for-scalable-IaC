# Resource Group Outputs
output "resource_group_id" {
  description = "ID of the resource group"
  value       = module.resource_group.resource_group_id
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.resource_group.resource_group_name
}

# Storage Account Outputs
output "storage_account_id" {
  description = "ID of the storage account"
  value       = module.tfstate_storage.storage_account_id
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = module.tfstate_storage.storage_account_name
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

# App Service Outputs
output "service_plan_id" {
  description = "ID of the App Service Plan"
  value       = module.bot_app_service.service_plan_id
}

output "web_app_id" {
  description = "ID of the Bot Web App"
  value       = module.bot_app_service.web_app_id
}

output "web_app_name" {
  description = "Name of the Bot Web App"
  value       = module.bot_app_service.web_app_name
}

output "web_app_url" {
  description = "URL of the Bot Web App"
  value       = module.bot_app_service.web_app_url
}

output "bot_messaging_endpoint" {
  description = "Bot messaging endpoint URL"
  value       = module.bot_app_service.bot_endpoint
}

# Azure Bot Outputs
output "bot_id" {
  description = "ID of the Azure Bot"
  value       = module.azure_bot.bot_id
}

output "bot_name" {
  description = "Name of the Azure Bot"
  value       = module.azure_bot.bot_name
}

output "bot_microsoft_app_id" {
  description = "Microsoft App ID of the Azure Bot"
  value       = module.azure_bot.bot_microsoft_app_id
}

output "bot_app_insights_id" {
  description = "ID of the Application Insights instance for bot"
  value       = module.azure_bot.app_insights_id
}

output "bot_app_insights_instrumentation_key" {
  description = "Instrumentation key for bot Application Insights"
  value       = module.azure_bot.app_insights_instrumentation_key
  sensitive   = true
}

output "bot_app_insights_connection_string" {
  description = "Connection string for bot Application Insights"
  value       = module.azure_bot.app_insights_connection_string
  sensitive   = true
}
