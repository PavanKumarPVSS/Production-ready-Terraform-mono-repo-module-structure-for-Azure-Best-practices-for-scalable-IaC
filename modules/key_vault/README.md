# Key Vault Module

This module creates an Azure Key Vault with optional secrets, keys, and access policies.

## Prerequisites

- **Resource Group**: An existing Azure Resource Group must be created first
- **Azure Authentication**: You must be authenticated with Azure CLI to retrieve tenant and client configuration
- **Virtual Network** (optional): Required only if using network ACLs with subnet restrictions
- **RBAC Permissions** (if using RBAC): Ensure you have appropriate permissions to assign roles on the Key Vault

## Features

- Creates Key Vault with Standard or Premium SKU
- Supports RBAC or Access Policy authorization
- Soft delete and purge protection options
- Network ACLs for secure access
- Creates secrets and keys
- Integration with VMs, disk encryption, and ARM templates

## Usage

### Basic Key Vault with RBAC

```hcl
module "key_vault" {
  source = "./modules/key_vault"

  key_vault_name      = "my-keyvault-123"
  resource_group_name = "my-resource-group"
  location            = "East US"
  sku_name            = "standard"

  enable_rbac_authorization = true
  purge_protection_enabled  = false

  tags = {
    environment = "production"
  }
}
```

### Key Vault with Access Policies and Secrets

```hcl
data "azurerm_client_config" "current" {}

module "key_vault" {
  source = "./modules/key_vault"

  key_vault_name      = "my-keyvault-123"
  resource_group_name = "my-resource-group"
  location            = "East US"
  sku_name            = "standard"

  enable_rbac_authorization = false
  purge_protection_enabled  = true

  access_policies = {
    "admin" = {
      object_id = data.azurerm_client_config.current.object_id
      key_permissions = [
        "Get", "List", "Create", "Delete", "Update"
      ]
      secret_permissions = [
        "Get", "List", "Set", "Delete"
      ]
      certificate_permissions = [
        "Get", "List", "Create", "Delete"
      ]
    }
  }

  secrets = {
    "database-password" = {
      value        = "SecurePassword123!"
      content_type = "password"
    }
    "api-key" = {
      value = "my-api-key-value"
    }
  }

  tags = {
    environment = "production"
  }
}
```

### Key Vault with Network ACLs

```hcl
module "key_vault" {
  source = "./modules/key_vault"

  key_vault_name      = "my-keyvault-123"
  resource_group_name = "my-resource-group"
  location            = "East US"

  enable_network_acls            = true
  network_acls_default_action    = "Deny"
  network_acls_bypass            = "AzureServices"
  network_acls_ip_rules          = ["203.0.113.0/24"]
  network_acls_subnet_ids        = [azurerm_subnet.example.id]

  tags = {
    environment = "production"
  }
}
```

### Key Vault with Cryptographic Keys

```hcl
module "key_vault" {
  source = "./modules/key_vault"

  key_vault_name      = "my-keyvault-123"
  resource_group_name = "my-resource-group"
  location            = "East US"

  enable_rbac_authorization = true

  keys = {
    "encryption-key" = {
      key_type = "RSA"
      key_size = 2048
      key_opts = ["decrypt", "encrypt", "sign", "verify"]
    }
  }

  tags = {
    environment = "production"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| key_vault_name | Key Vault name (3-24 chars, alphanumeric and hyphens) | `string` | n/a | yes |
| resource_group_name | Name of the resource group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| sku_name | SKU (standard or premium) | `string` | `"standard"` | no |
| soft_delete_retention_days | Soft delete retention (7-90 days) | `number` | `90` | no |
| purge_protection_enabled | Enable purge protection | `bool` | `false` | no |
| enable_rbac_authorization | Use RBAC instead of access policies | `bool` | `false` | no |
| enabled_for_deployment | Enable for VM deployment | `bool` | `false` | no |
| enabled_for_disk_encryption | Enable for disk encryption | `bool` | `false` | no |
| enabled_for_template_deployment | Enable for ARM template deployment | `bool` | `false` | no |
| enable_network_acls | Enable network ACLs | `bool` | `false` | no |
| network_acls_default_action | Default action (Allow or Deny) | `string` | `"Deny"` | no |
| network_acls_ip_rules | Allowed IP addresses/CIDR blocks | `list(string)` | `[]` | no |
| network_acls_subnet_ids | Allowed subnet IDs | `list(string)` | `[]` | no |
| access_policies | Map of access policies (when RBAC disabled) | `map(object)` | `{}` | no |
| secrets | Map of secrets to create | `map(object)` | `{}` | no |
| keys | Map of keys to create | `map(object)` | `{}` | no |
| tags | Tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| key_vault_id | ID of the Key Vault |
| key_vault_name | Name of the Key Vault |
| key_vault_uri | URI of the Key Vault |
| key_vault_tenant_id | Tenant ID |
| secret_ids | Map of secret names to IDs |
| secret_versions | Map of secret names to version IDs |
| key_ids | Map of key names to IDs |
| key_versions | Map of key names to version IDs |

## Notes

- Choose RBAC authorization for modern Azure environments
- Access policies are legacy but still supported
- Purge protection prevents permanent deletion
- Network ACLs enhance security by restricting access
