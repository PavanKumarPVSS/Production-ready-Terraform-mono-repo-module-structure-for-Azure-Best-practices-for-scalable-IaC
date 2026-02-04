# App Service Module

This module creates an Azure App Service Plan and Web App (Linux or Windows).

## Prerequisites

- **Resource Group**: An existing Azure Resource Group must be created first

## Features

- Creates App Service Plan with configurable SKU
- Supports both Linux and Windows web apps
- Conditional creation based on OS type
- Multiple runtime stacks for Windows (node, dotnet, java, php, python)
- Node.js support for Linux
- HTTPS enforcement
- Configurable app settings

## Usage

### Linux Web App

```hcl
module "app_service" {
  source = "./modules/app_service"

  resource_group_name = "my-resource-group"
  location            = "East US"
  service_plan_name   = "my-service-plan"
  os_type             = "Linux"
  sku_name            = "B1"
  web_app_name        = "my-linux-webapp"
  node_version        = "18-lts"

  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "~18"
  }

  tags = {
    environment = "production"
  }
}
```

### Windows Web App

```hcl
module "app_service" {
  source = "./modules/app_service"

  resource_group_name      = "my-resource-group"
  location                 = "East US"
  service_plan_name        = "my-service-plan"
  os_type                  = "Windows"
  sku_name                 = "B1"
  web_app_name             = "my-windows-webapp"
  windows_current_stack    = "dotnet"
  dotnet_version           = "v8.0"

  app_settings = {
    "ASPNETCORE_ENVIRONMENT" = "Production"
  }

  tags = {
    environment = "production"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Name of the resource group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| service_plan_name | Name of App Service Plan | `string` | n/a | yes |
| os_type | OS type (Linux or Windows) | `string` | `"Linux"` | no |
| sku_name | SKU for App Service Plan | `string` | `"F1"` | no |
| web_app_name | Name of the Web App | `string` | n/a | yes |
| node_version | Node.js version | `string` | `"18-lts"` | no |
| windows_current_stack | Windows runtime stack | `string` | `"node"` | no |
| dotnet_version | .NET version for Windows | `string` | `"v8.0"` | no |
| java_version | Java version for Windows | `string` | `"17"` | no |
| php_version | PHP version for Windows | `string` | `"8.2"` | no |
| python_version | Python version for Windows | `string` | `"3.11"` | no |
| app_settings | Application settings | `map(string)` | `{}` | no |
| tags | Tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| service_plan_id | ID of the App Service Plan |
| service_plan_name | Name of the App Service Plan |
| web_app_id | ID of the Web App |
| web_app_name | Name of the Web App |
| web_app_default_hostname | Default hostname |
| web_app_url | HTTPS URL of the web app |
| bot_endpoint | Bot messaging endpoint URL |

## Notes

- F1 (Free) tier does not support `always_on` feature
- Choose B1 or higher for production workloads
- Windows apps support multiple runtime stacks via `windows_current_stack` variable
