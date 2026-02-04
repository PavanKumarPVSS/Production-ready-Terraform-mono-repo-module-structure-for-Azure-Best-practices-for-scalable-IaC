# Terraform State Storage Module

This module creates an Azure Storage Account and Blob Container for storing Terraform state files.

## Prerequisites

- **Resource Group**: An existing Azure Resource Group must be created first

## Features

- Creates a storage account with secure defaults
- Creates a blob container for tfstate files
- Supports encryption and versioning

## Usage

```hcl
module "tfstate_storage" {
  source = "./modules/tfstate_storage"

  storage_account_name = "tfstatestorage12345"
  resource_group_name  = "my-resource-group"
  location             = "East US"
  container_name       = "tfstate"

  tags = {
    environment = "production"
    purpose     = "terraform-state"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| storage_account_name | Name of the storage account | `string` | n/a | yes |
| resource_group_name | Name of the resource group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| container_name | Name of the blob container | `string` | n/a | yes |
| tags | Tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| storage_account_id | ID of the storage account |
| storage_account_name | Name of the storage account |
| container_name | Name of the blob container |
| primary_access_key | Primary access key (sensitive) |
