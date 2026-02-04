# Azure Function App Module

This module creates an Azure Function App with its required resources including App Service Plan, Storage Account, and optional Application Insights.

## Features

- ✅ Support for both Linux and Windows Function Apps
- ✅ Multiple hosting plans (Consumption, Premium, Dedicated)
- ✅ Multiple runtime stacks (.NET, Node.js, Python, Java, PowerShell)
- ✅ Application Insights integration for monitoring
- ✅ Managed Identity support (System-assigned and User-assigned)
- ✅ CORS configuration
- ✅ HTTPS enforcement
- ✅ Custom app settings

## Prerequisites

1. **Resource Group**: Must exist before deploying this module
2. **Azure Subscription**: Active subscription with appropriate permissions
3. **Service Principal**: With Contributor role or equivalent for resource creation
4. **Runtime Requirements**: Ensure selected runtime version is supported in your region

## Resources Created

- `azurerm_storage_account`: Required storage account for Function App
- `azurerm_service_plan`: App Service Plan for hosting
- `azurerm_linux_function_app` or `azurerm_windows_function_app`: Function App (based on OS type)
- `azurerm_application_insights`: Optional monitoring resource

## Usage

### Basic Linux Function App (Consumption Plan)

```hcl
module "function_app" {
  source = "./modules/function_app"

  function_app_name        = "my-func-app"
  resource_group_name      = "my-rg"
  location                 = "eastus"
  storage_account_name     = "myfuncstorage123"
  app_service_plan_name    = "my-func-plan"
  application_insights_name = "my-func-insights"

  os_type      = "Linux"
  sku_name     = "Y1"  # Consumption Plan
  runtime_name = "python"
  runtime_version = "3.11"

  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}
```

### Windows Function App with .NET (Premium Plan)

```hcl
module "function_app_dotnet" {
  source = "./modules/function_app"

  function_app_name        = "my-dotnet-func"
  resource_group_name      = "my-rg"
  location                 = "eastus"
  storage_account_name     = "mydotnetstorage123"
  app_service_plan_name    = "my-premium-plan"
  application_insights_name = "my-dotnet-insights"

  os_type      = "Windows"
  sku_name     = "EP1"  # Premium Plan
  always_on    = true
  runtime_name = "dotnet-isolated"
  runtime_version = "8.0"

  app_settings = {
    "CUSTOM_SETTING" = "value"
  }

  cors_allowed_origins = ["https://example.com"]

  tags = {
    Environment = "Production"
    Application = "API"
  }
}
```

### Node.js Function App (Dedicated Plan)

```hcl
module "function_app_node" {
  source = "./modules/function_app"

  function_app_name        = "my-node-func"
  resource_group_name      = "my-rg"
  location                 = "eastus"
  storage_account_name     = "mynodestorage123"
  app_service_plan_name    = "my-app-plan"
  application_insights_name = "my-node-insights"

  os_type      = "Linux"
  sku_name     = "P1V2"  # Dedicated Plan
  always_on    = true
  runtime_name = "node"
  runtime_version = "20"

  identity_type = "SystemAssigned"

  tags = {
    Environment = "QA"
  }
}
```

### Function App without Application Insights

```hcl
module "function_app_no_insights" {
  source = "./modules/function_app"

  function_app_name        = "my-simple-func"
  resource_group_name      = "my-rg"
  location                 = "eastus"
  storage_account_name     = "mysimplestorage123"
  app_service_plan_name    = "my-simple-plan"

  os_type                     = "Linux"
  sku_name                    = "Y1"
  enable_application_insights = false
  runtime_name                = "python"
  runtime_version             = "3.11"

  tags = {
    Environment = "Development"
  }
}
```

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `function_app_name` | Name of the Function App | `string` | - | yes |
| `resource_group_name` | Name of the resource group | `string` | - | yes |
| `location` | Azure region | `string` | - | yes |
| `storage_account_name` | Storage account name (3-24 chars, lowercase, alphanumeric) | `string` | - | yes |
| `app_service_plan_name` | App Service Plan name | `string` | - | yes |
| `os_type` | Operating system (Linux or Windows) | `string` | `"Linux"` | no |
| `sku_name` | SKU name (Y1, EP1-EP3, S1-S3, P1V2-P3V2) | `string` | `"Y1"` | no |
| `runtime_name` | Runtime stack (dotnet, node, python, java, powershell) | `string` | `null` | no |
| `runtime_version` | Runtime version | `string` | `null` | no |
| `enable_application_insights` | Enable Application Insights | `bool` | `true` | no |
| `application_insights_name` | Application Insights name | `string` | `""` | no |
| `always_on` | Keep Function App always on | `bool` | `false` | no |
| `https_only` | Force HTTPS only | `bool` | `true` | no |
| `app_settings` | Custom app settings | `map(string)` | `{}` | no |
| `cors_allowed_origins` | CORS allowed origins | `list(string)` | `[]` | no |
| `identity_type` | Managed Identity type | `string` | `"SystemAssigned"` | no |
| `tags` | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `function_app_id` | ID of the Function App |
| `function_app_name` | Name of the Function App |
| `function_app_default_hostname` | Default hostname of the Function App |
| `function_app_url` | Full HTTPS URL of the Function App |
| `function_app_identity_principal_id` | Principal ID of the managed identity |
| `app_service_plan_id` | ID of the App Service Plan |
| `storage_account_id` | ID of the storage account |
| `application_insights_instrumentation_key` | Application Insights instrumentation key (sensitive) |

## SKU Reference

### Consumption Plan (Serverless)
- **Y1**: Pay-per-execution, automatic scaling, 1.5 GB memory, 5-minute timeout

### Premium Plans (Enhanced Features)
- **EP1**: 3.5 GB memory, 210 ACU, VNET integration
- **EP2**: 7 GB memory, 420 ACU
- **EP3**: 14 GB memory, 840 ACU

### Dedicated Plans (App Service Plan)
- **S1/S2/S3**: Basic tier, 1.75-7 GB memory
- **P1V2/P2V2/P3V2**: Premium v2, 3.5-14 GB memory, better performance

## Runtime Versions

### .NET
- Linux/Windows: `6.0`, `8.0`
- Use `dotnet-isolated` for isolated worker process

### Node.js
- Linux/Windows: `18`, `20`

### Python
- Linux only: `3.9`, `3.10`, `3.11`

### Java
- Linux/Windows: `8`, `11`, `17`

### PowerShell
- Windows only: `7.2`

## Important Notes

1. **Storage Account Naming**: Must be 3-24 characters, lowercase letters and numbers only
2. **Always On**: Not available with Consumption (Y1) plan
3. **Runtime Support**: Python is Linux-only; PowerShell is Windows-only
4. **Application Insights**: Highly recommended for production workloads
5. **Managed Identity**: SystemAssigned identity is recommended for Azure service integration

## Dependencies

This module depends on:
- Existing Resource Group
- Azure Provider configuration with appropriate permissions

## Deployment Order

1. Deploy Resource Group first
2. Deploy Function App module
3. Deploy application code to Function App

## Example with Complete Configuration

```hcl
module "production_function_app" {
  source = "./modules/function_app"

  function_app_name        = "prod-api-func-app"
  resource_group_name      = module.resource_group.resource_group_name
  location                 = "eastus"
  storage_account_name     = "prodapifuncstorage"
  app_service_plan_name    = "prod-api-func-plan"
  application_insights_name = "prod-api-func-insights"

  os_type         = "Linux"
  sku_name        = "EP2"
  always_on       = true
  runtime_name    = "node"
  runtime_version = "20"

  app_settings = {
    "NODE_ENV"                    = "production"
    "API_KEY"                     = "@Microsoft.KeyVault(SecretUri=https://mykv.vault.azure.net/secrets/apikey/)"
    "WEBSITE_RUN_FROM_PACKAGE"    = "1"
    "FUNCTIONS_WORKER_RUNTIME"    = "node"
  }

  cors_allowed_origins = [
    "https://app.example.com",
    "https://admin.example.com"
  ]

  cors_support_credentials = true

  identity_type = "SystemAssigned"

  https_only = true

  storage_account_tier             = "Standard"
  storage_account_replication_type = "GRS"

  tags = {
    Environment      = "Production"
    Application      = "API Backend"
    ManagedBy        = "Terraform"
    CostCenter       = "Engineering"
    DataClassification = "Internal"
  }
}
```

## Best Practices

1. **Use Premium or Dedicated plans for production** workloads requiring VNET integration or consistent performance
2. **Enable Application Insights** for all production Function Apps
3. **Use Managed Identities** instead of connection strings for Azure service access
4. **Enable HTTPS only** (default: true)
5. **Use Key Vault references** for sensitive app settings
6. **Set appropriate CORS policies** if accessed from web applications
7. **Use GRS replication** for storage account in production
8. **Tag all resources** for cost tracking and organization

## Troubleshooting

- **Storage account name conflicts**: Ensure globally unique name (3-24 chars, lowercase alphanumeric)
- **Runtime not supported**: Verify runtime version is available in your region
- **Always On not working**: Consumption plan doesn't support always_on
- **Identity not created**: Check identity_type is set correctly
