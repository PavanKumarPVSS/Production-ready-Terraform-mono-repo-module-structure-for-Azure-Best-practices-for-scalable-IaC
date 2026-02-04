# Azure Bot Module

This module creates an Azure Bot Service with Application Insights monitoring.

## Prerequisites

- **Resource Group**: An existing Azure Resource Group must be created first
- **Bot Endpoint**: A web app or function app hosting the bot logic must be deployed first to provide the messaging endpoint URL
- **Azure Authentication**: You must be authenticated with Azure CLI or have appropriate credentials configured

## Deployment Order

1. Deploy Resource Group
2. Deploy App Service (web app for bot backend)
3. Deploy Azure Bot (uses endpoint from App Service)

## Features

- Creates Application Insights for bot monitoring
- Creates Application Insights API key
- Creates Azure Bot Service (Web App Bot)
- Supports F0 (free) and S1 (standard) SKUs
- Automatically integrates with App Insights

## Usage

```hcl
module "azure_bot" {
  source = "./modules/azure_bot"

  resource_group_name = "my-resource-group"
  location            = "East US"
  app_insights_name   = "my-bot-insights"
  api_key_name        = "bot-api-key"
  bot_name            = "my-azure-bot"
  bot_location        = "global"
  bot_sku             = "F0"
  bot_endpoint        = "https://my-bot-app.azurewebsites.net/api/messages"

  tags = {
    environment = "production"
    purpose     = "chatbot"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Name of the resource group | `string` | n/a | yes |
| location | Azure region for resources | `string` | n/a | yes |
| app_insights_name | Name of Application Insights | `string` | n/a | yes |
| api_key_name | Name of API key | `string` | n/a | yes |
| bot_name | Name of the Azure Bot | `string` | n/a | yes |
| bot_location | Bot location (typically 'global') | `string` | `"global"` | no |
| bot_sku | Bot SKU (F0 or S1) | `string` | `"F0"` | no |
| bot_endpoint | Bot messaging endpoint URL | `string` | n/a | yes |
| application_type | App Insights type | `string` | `"web"` | no |
| tags | Tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| bot_id | ID of the Azure Bot |
| bot_name | Name of the Azure Bot |
| bot_microsoft_app_id | Microsoft App ID |
| app_insights_id | ID of Application Insights |
| app_insights_instrumentation_key | Instrumentation key (sensitive) |
| app_insights_connection_string | Connection string (sensitive) |
