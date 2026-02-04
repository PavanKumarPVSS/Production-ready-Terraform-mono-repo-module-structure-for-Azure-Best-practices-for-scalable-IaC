output "service_plan_id" {
  description = "ID of the App Service Plan"
  value       = azurerm_service_plan.bot_plan.id
}

output "service_plan_name" {
  description = "Name of the App Service Plan"
  value       = azurerm_service_plan.bot_plan.name
}

output "web_app_id" {
  description = "ID of the Web App"
  value       = length(azurerm_linux_web_app.bot_app) > 0 ? azurerm_linux_web_app.bot_app[0].id : azurerm_windows_web_app.bot_app[0].id
}

output "web_app_name" {
  description = "Name of the Web App"
  value       = length(azurerm_linux_web_app.bot_app) > 0 ? azurerm_linux_web_app.bot_app[0].name : azurerm_windows_web_app.bot_app[0].name
}

output "web_app_default_hostname" {
  description = "Default hostname of the web app"
  value       = length(azurerm_linux_web_app.bot_app) > 0 ? azurerm_linux_web_app.bot_app[0].default_hostname : azurerm_windows_web_app.bot_app[0].default_hostname
}

output "web_app_url" {
  description = "URL of the web app"
  value       = length(azurerm_linux_web_app.bot_app) > 0 ? "https://${azurerm_linux_web_app.bot_app[0].default_hostname}" : "https://${azurerm_windows_web_app.bot_app[0].default_hostname}"
}

output "bot_endpoint" {
  description = "Bot messaging endpoint URL"
  value       = length(azurerm_linux_web_app.bot_app) > 0 ? "https://${azurerm_linux_web_app.bot_app[0].default_hostname}/api/messages" : "https://${azurerm_windows_web_app.bot_app[0].default_hostname}/api/messages"
}
