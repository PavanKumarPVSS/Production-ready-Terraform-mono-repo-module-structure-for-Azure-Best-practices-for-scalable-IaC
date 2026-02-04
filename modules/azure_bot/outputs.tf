output "bot_id" {
  description = "ID of the Azure Bot"
  value       = azurerm_bot_service_azure_bot.bot.id
}

output "bot_name" {
  description = "Name of the Azure Bot"
  value       = azurerm_bot_service_azure_bot.bot.name
}

output "bot_microsoft_app_id" {
  description = "Microsoft App ID of the Azure Bot"
  value       = azurerm_bot_service_azure_bot.bot.microsoft_app_id
}

output "app_insights_id" {
  description = "ID of the Application Insights instance"
  value       = azurerm_application_insights.bot.id
}

output "app_insights_instrumentation_key" {
  description = "Instrumentation key for Application Insights"
  value       = azurerm_application_insights.bot.instrumentation_key
  sensitive   = true
}

output "app_insights_connection_string" {
  description = "Connection string for Application Insights"
  value       = azurerm_application_insights.bot.connection_string
  sensitive   = true
}
