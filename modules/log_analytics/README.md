# Azure Log Analytics Workspace Module

This module creates an Azure Log Analytics Workspace with optional solutions for monitoring and diagnostics.

## Features

- ✅ Configurable SKU and retention
- ✅ Daily quota management
- ✅ Internet ingestion and query controls
- ✅ Support for Log Analytics Solutions (ContainerInsights, Security, etc.)
- ✅ Integration with AKS, VMs, and other Azure services

## Prerequisites

1. **Resource Group**: Must exist before deploying
2. **Azure Subscription**: Active subscription with permissions
3. **Service Principal**: With Log Analytics Contributor role

## Resources Created

- `azurerm_log_analytics_workspace`: Log Analytics Workspace
- `azurerm_log_analytics_solution`: Optional solutions (ContainerInsights, etc.)

## Usage

### Basic Workspace

```hcl
module "log_analytics" {
  source = "./modules/log_analytics"

  workspace_name      = "log-analytics-prod"
  resource_group_name = "rg-monitoring"
  location            = "eastus"
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = {
    Environment = "Production"
  }
}
```

### Workspace with Container Insights for AKS

```hcl
module "log_analytics_aks" {
  source = "./modules/log_analytics"

  workspace_name      = "log-analytics-aks"
  resource_group_name = "rg-aks-monitoring"
  location            = "eastus"
  sku                 = "PerGB2018"
  retention_in_days   = 90

  solutions = [
    "ContainerInsights",
    "SecurityCenterFree"
  ]

  tags = {
    Environment = "Production"
    Purpose     = "AKS Monitoring"
  }
}
```

### Workspace with Daily Quota

```hcl
module "log_analytics_quota" {
  source = "./modules/log_analytics"

  workspace_name      = "log-analytics-dev"
  resource_group_name = "rg-dev"
  location            = "eastus"
  sku                 = "PerGB2018"
  retention_in_days   = 30
  daily_quota_gb      = 5

  tags = {
    Environment = "Development"
  }
}
```

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `workspace_name` | Name of the Log Analytics Workspace | `string` | - | yes |
| `resource_group_name` | Name of the resource group | `string` | - | yes |
| `location` | Azure region | `string` | - | yes |
| `sku` | Workspace SKU | `string` | `"PerGB2018"` | no |
| `retention_in_days` | Data retention in days (30-730, or 7 for Free) | `number` | `30` | no |
| `daily_quota_gb` | Daily ingestion limit in GB (-1 for unlimited) | `number` | `-1` | no |
| `internet_ingestion_enabled` | Allow public internet ingestion | `bool` | `true` | no |
| `internet_query_enabled` | Allow public internet queries | `bool` | `true` | no |
| `solutions` | List of solutions to enable | `list(string)` | `[]` | no |
| `tags` | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `workspace_id` | ID of the Log Analytics Workspace |
| `workspace_name` | Name of the workspace |
| `workspace_customer_id` | Workspace (Customer) ID |
| `primary_shared_key` | Primary shared key (sensitive) |
| `workspace_location` | Location of the workspace |

## Available SKUs

- **Free**: 500 MB/day limit, 7 days retention
- **PerGB2018**: Pay-as-you-go, most common
- **CapacityReservation**: Reserved capacity pricing
- **PerNode**: Legacy per-node pricing
- **Standard/Premium**: Legacy SKUs

## Common Solutions

- `ContainerInsights` - Container monitoring for AKS
- `SecurityCenterFree` - Azure Security Center free tier
- `Security` - Security and Audit solution
- `Updates` - Update Management
- `ChangeTracking` - Change Tracking and Inventory
- `ServiceMap` - Service Map
- `SQLAssessment` - SQL Server Health Check

## Best Practices

1. **Use PerGB2018 SKU** for most workloads (pay-as-you-go)
2. **Set appropriate retention** based on compliance requirements
3. **Enable ContainerInsights** when monitoring AKS clusters
4. **Use daily quota** for cost control in non-production environments
5. **Monitor workspace usage** to optimize costs
6. **Keep retention between 30-90 days** for most scenarios

## Dependencies

- Existing Resource Group

## Example with AKS Integration

```hcl
# Log Analytics for AKS
module "log_analytics" {
  source = "./modules/log_analytics"

  workspace_name      = "log-aks-prod"
  resource_group_name = module.resource_group.resource_group_name
  location            = "eastus"
  sku                 = "PerGB2018"
  retention_in_days   = 90

  solutions = ["ContainerInsights"]

  tags = {
    Environment = "Production"
    Application = "AKS Monitoring"
  }
}

# AKS Cluster with Log Analytics
module "aks" {
  source = "./modules/aks"

  cluster_name               = "aks-prod"
  resource_group_name        = module.resource_group.resource_group_name
  location                   = "eastus"
  dns_prefix                 = "aks-prod"
  log_analytics_workspace_id = module.log_analytics.workspace_id

  # ... other AKS configuration
}
```

## Troubleshooting

- **Quota exceeded**: Increase daily_quota_gb or set to -1 for unlimited
- **Solution deployment fails**: Ensure workspace is created first
- **High costs**: Review retention settings and enable daily quota
