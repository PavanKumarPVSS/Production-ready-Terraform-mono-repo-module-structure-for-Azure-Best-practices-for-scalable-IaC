# Azure Log Analytics Workspace Module

resource "azurerm_log_analytics_workspace" "workspace" {
  name                = var.workspace_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  retention_in_days   = var.retention_in_days

  daily_quota_gb = var.daily_quota_gb

  internet_ingestion_enabled = var.internet_ingestion_enabled
  internet_query_enabled     = var.internet_query_enabled

  tags = var.tags
}

# Log Analytics Solutions
resource "azurerm_log_analytics_solution" "solutions" {
  for_each = toset(var.solutions)

  solution_name         = each.value
  resource_group_name   = var.resource_group_name
  location              = var.location
  workspace_resource_id = azurerm_log_analytics_workspace.workspace.id
  workspace_name        = azurerm_log_analytics_workspace.workspace.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/${each.value}"
  }

  tags = var.tags
}
