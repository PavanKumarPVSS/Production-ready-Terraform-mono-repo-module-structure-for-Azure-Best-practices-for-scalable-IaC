# Azure Function App Module

# Storage Account for Function App (required)
resource "azurerm_storage_account" "function_storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  min_tls_version          = "TLS1_2"

  tags = var.tags
}

# Application Insights for Function App monitoring
resource "azurerm_application_insights" "function_insights" {
  count               = var.enable_application_insights ? 1 : 0
  name                = var.application_insights_name
  resource_group_name = var.resource_group_name
  location            = var.location
  application_type    = var.application_insights_type

  tags = var.tags
}

# App Service Plan for Function App
resource "azurerm_service_plan" "function_plan" {
  name                = var.app_service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name

  tags = var.tags
}

# Linux Function App
resource "azurerm_linux_function_app" "function_app" {
  count                      = var.os_type == "Linux" ? 1 : 0
  name                       = var.function_app_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  service_plan_id            = azurerm_service_plan.function_plan.id
  storage_account_name       = azurerm_storage_account.function_storage.name
  storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key

  site_config {
    always_on                               = var.always_on
    application_insights_connection_string  = var.enable_application_insights ? azurerm_application_insights.function_insights[0].connection_string : null
    application_insights_key                = var.enable_application_insights ? azurerm_application_insights.function_insights[0].instrumentation_key : null

    dynamic "application_stack" {
      for_each = var.runtime_name != null ? [1] : []
      content {
        dotnet_version              = var.runtime_name == "dotnet" ? var.runtime_version : null
        use_dotnet_isolated_runtime = var.runtime_name == "dotnet-isolated" ? true : null
        java_version                = var.runtime_name == "java" ? var.runtime_version : null
        node_version                = var.runtime_name == "node" ? var.runtime_version : null
        python_version              = var.runtime_name == "python" ? var.runtime_version : null
        powershell_core_version     = var.runtime_name == "powershell" ? var.runtime_version : null
      }
    }

    cors {
      allowed_origins     = var.cors_allowed_origins
      support_credentials = var.cors_support_credentials
    }
  }

  app_settings = merge(
    var.app_settings,
    var.enable_application_insights ? {
      "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.function_insights[0].connection_string
      "ApplicationInsightsAgent_EXTENSION_VERSION" = "~3"
    } : {}
  )

  identity {
    type = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" || var.identity_type == "SystemAssigned, UserAssigned" ? var.identity_ids : null
  }

  https_only = var.https_only

  tags = var.tags

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
    ]
  }
}

# Windows Function App
resource "azurerm_windows_function_app" "function_app" {
  count                      = var.os_type == "Windows" ? 1 : 0
  name                       = var.function_app_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  service_plan_id            = azurerm_service_plan.function_plan.id
  storage_account_name       = azurerm_storage_account.function_storage.name
  storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key

  site_config {
    always_on                               = var.always_on
    application_insights_connection_string  = var.enable_application_insights ? azurerm_application_insights.function_insights[0].connection_string : null
    application_insights_key                = var.enable_application_insights ? azurerm_application_insights.function_insights[0].instrumentation_key : null

    dynamic "application_stack" {
      for_each = var.runtime_name != null ? [1] : []
      content {
        dotnet_version              = var.runtime_name == "dotnet" ? var.runtime_version : null
        use_dotnet_isolated_runtime = var.runtime_name == "dotnet-isolated" ? true : null
        java_version                = var.runtime_name == "java" ? var.runtime_version : null
        node_version                = var.runtime_name == "node" ? var.runtime_version : null
        powershell_core_version     = var.runtime_name == "powershell" ? var.runtime_version : null
      }
    }

    cors {
      allowed_origins     = var.cors_allowed_origins
      support_credentials = var.cors_support_credentials
    }
  }

  app_settings = merge(
    var.app_settings,
    var.enable_application_insights ? {
      "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.function_insights[0].connection_string
      "ApplicationInsightsAgent_EXTENSION_VERSION" = "~3"
    } : {}
  )

  identity {
    type = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" || var.identity_type == "SystemAssigned, UserAssigned" ? var.identity_ids : null
  }

  https_only = var.https_only

  tags = var.tags

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
    ]
  }
}
