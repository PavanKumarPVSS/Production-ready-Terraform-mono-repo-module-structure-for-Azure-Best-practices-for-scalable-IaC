# Log Analytics Workspace Outputs

output "workspace_id" {
  description = "ID of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.workspace.id
}

output "workspace_name" {
  description = "Name of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.workspace.name
}

output "workspace_customer_id" {
  description = "Workspace (Customer) ID of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.workspace.workspace_id
}

output "primary_shared_key" {
  description = "Primary shared key for the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.workspace.primary_shared_key
  sensitive   = true
}

output "secondary_shared_key" {
  description = "Secondary shared key for the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.workspace.secondary_shared_key
  sensitive   = true
}

output "workspace_location" {
  description = "Location of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.workspace.location
}
