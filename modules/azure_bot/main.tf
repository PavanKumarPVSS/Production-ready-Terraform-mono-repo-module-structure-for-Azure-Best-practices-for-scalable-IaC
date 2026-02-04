# Application Insights for Bot Monitoring
resource "azurerm_application_insights" "bot" {
  name                = var.app_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = var.application_type

  tags = var.tags
}

# Application Insights API Key
resource "azurerm_application_insights_api_key" "bot" {
  name                    = var.api_key_name
  application_insights_id = azurerm_application_insights.bot.id
  read_permissions        = ["aggregate", "api", "draft", "extendqueries", "search"]
}

# Data source for current Azure client configuration
data "azurerm_client_config" "current" {}

# Azure Bot Service
resource "azurerm_bot_service_azure_bot" "bot" {
  name                = var.bot_name
  resource_group_name = var.resource_group_name
  location            = var.bot_location
  microsoft_app_id    = data.azurerm_client_config.current.client_id
  sku                 = var.bot_sku

  endpoint                              = var.bot_endpoint
  developer_app_insights_api_key        = azurerm_application_insights_api_key.bot.api_key
  developer_app_insights_application_id = azurerm_application_insights.bot.app_id

  tags = var.tags
}
