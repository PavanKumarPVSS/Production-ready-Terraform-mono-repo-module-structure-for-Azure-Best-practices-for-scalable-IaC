# Data source for current Azure client configuration
data "azurerm_client_config" "current" {}

# Key Vault
resource "azurerm_key_vault" "kv" {
  name                       = var.key_vault_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = var.sku_name
  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment

  public_network_access_enabled = var.public_network_access_enabled

  dynamic "network_acls" {
    for_each = var.enable_network_acls ? [1] : []
    content {
      default_action             = var.network_acls_default_action
      bypass                     = var.network_acls_bypass
      ip_rules                   = var.network_acls_ip_rules
      virtual_network_subnet_ids = var.network_acls_subnet_ids
    }
  }

  tags = var.tags
}

# Access Policies (if not using RBAC)
resource "azurerm_key_vault_access_policy" "policies" {
  for_each = var.enable_rbac_authorization ? {} : var.access_policies

  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = each.value.object_id

  key_permissions         = lookup(each.value, "key_permissions", [])
  secret_permissions      = lookup(each.value, "secret_permissions", [])
  certificate_permissions = lookup(each.value, "certificate_permissions", [])
  storage_permissions     = lookup(each.value, "storage_permissions", [])
}

# Secrets
resource "azurerm_key_vault_secret" "secrets" {
  for_each = var.secrets

  name         = each.key
  value        = each.value.value
  key_vault_id = azurerm_key_vault.kv.id
  content_type = lookup(each.value, "content_type", null)

  dynamic "expiration_date" {
    for_each = lookup(each.value, "expiration_date", null) != null ? [1] : []
    content {
      expiration_date = each.value.expiration_date
    }
  }

  depends_on = [azurerm_key_vault_access_policy.policies]
}

# Keys
resource "azurerm_key_vault_key" "keys" {
  for_each = var.keys

  name         = each.key
  key_vault_id = azurerm_key_vault.kv.id
  key_type     = each.value.key_type
  key_size     = lookup(each.value, "key_size", null)
  key_opts     = each.value.key_opts

  dynamic "expiration_date" {
    for_each = lookup(each.value, "expiration_date", null) != null ? [1] : []
    content {
      expiration_date = each.value.expiration_date
    }
  }

  depends_on = [azurerm_key_vault_access_policy.policies]
}
