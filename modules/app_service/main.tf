# App Service Plan
resource "azurerm_service_plan" "bot_plan" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = var.os_type
  sku_name            = var.sku_name

  tags = var.tags
}

# Linux Web App
resource "azurerm_linux_web_app" "bot_app" {
  count = var.os_type == "Linux" ? 1 : 0

  name                = var.web_app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.bot_plan.id

  site_config {
    always_on = var.sku_name == "F1" ? false : true

    application_stack {
      node_version = var.node_version
    }
  }

  app_settings = var.app_settings

  https_only = true

  tags = var.tags
}

# Windows Web App
resource "azurerm_windows_web_app" "bot_app" {
  count = var.os_type == "Windows" ? 1 : 0

  name                = var.web_app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.bot_plan.id

  site_config {
    always_on = var.sku_name == "F1" ? false : true

    application_stack {
      current_stack  = var.windows_current_stack
      node_version   = var.windows_current_stack == "node" ? var.node_version : null
      dotnet_version = var.windows_current_stack == "dotnet" ? var.dotnet_version : null
      java_version   = var.windows_current_stack == "java" ? var.java_version : null
      php_version    = var.windows_current_stack == "php" ? var.php_version : null
      python         = var.windows_current_stack == "python" ? var.python_version : null
    }
  }

  app_settings = var.app_settings

  https_only = true

  tags = var.tags
}
