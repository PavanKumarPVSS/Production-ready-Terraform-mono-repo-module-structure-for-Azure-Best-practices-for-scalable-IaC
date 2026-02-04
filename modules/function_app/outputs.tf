# Function App Module Outputs

output "function_app_id" {
  description = "ID of the Function App"
  value       = var.os_type == "Linux" ? azurerm_linux_function_app.function_app[0].id : azurerm_windows_function_app.function_app[0].id
}

output "function_app_name" {
  description = "Name of the Function App"
  value       = var.os_type == "Linux" ? azurerm_linux_function_app.function_app[0].name : azurerm_windows_function_app.function_app[0].name
}

output "function_app_default_hostname" {
  description = "Default hostname of the Function App"
  value       = var.os_type == "Linux" ? azurerm_linux_function_app.function_app[0].default_hostname : azurerm_windows_function_app.function_app[0].default_hostname
}

output "function_app_url" {
  description = "URL of the Function App"
  value       = var.os_type == "Linux" ? "https://${azurerm_linux_function_app.function_app[0].default_hostname}" : "https://${azurerm_windows_function_app.function_app[0].default_hostname}"
}

output "function_app_identity_principal_id" {
  description = "Principal ID of the Function App's managed identity"
  value       = var.os_type == "Linux" ? azurerm_linux_function_app.function_app[0].identity[0].principal_id : azurerm_windows_function_app.function_app[0].identity[0].principal_id
}

output "function_app_identity_tenant_id" {
  description = "Tenant ID of the Function App's managed identity"
  value       = var.os_type == "Linux" ? azurerm_linux_function_app.function_app[0].identity[0].tenant_id : azurerm_windows_function_app.function_app[0].identity[0].tenant_id
}

output "app_service_plan_id" {
  description = "ID of the App Service Plan"
  value       = azurerm_service_plan.function_plan.id
}

output "app_service_plan_name" {
  description = "Name of the App Service Plan"
  value       = azurerm_service_plan.function_plan.name
}

output "storage_account_id" {
  description = "ID of the Function App's storage account"
  value       = azurerm_storage_account.function_storage.id
}

output "storage_account_name" {
  description = "Name of the Function App's storage account"
  value       = azurerm_storage_account.function_storage.name
}

output "storage_account_primary_connection_string" {
  description = "Primary connection string for the storage account"
  value       = azurerm_storage_account.function_storage.primary_connection_string
  sensitive   = true
}

output "application_insights_id" {
  description = "ID of Application Insights (if enabled)"
  value       = var.enable_application_insights ? azurerm_application_insights.function_insights[0].id : null
}

output "application_insights_instrumentation_key" {
  description = "Instrumentation key for Application Insights (if enabled)"
  value       = var.enable_application_insights ? azurerm_application_insights.function_insights[0].instrumentation_key : null
  sensitive   = true
}

output "application_insights_connection_string" {
  description = "Connection string for Application Insights (if enabled)"
  value       = var.enable_application_insights ? azurerm_application_insights.function_insights[0].connection_string : null
  sensitive   = true
}
