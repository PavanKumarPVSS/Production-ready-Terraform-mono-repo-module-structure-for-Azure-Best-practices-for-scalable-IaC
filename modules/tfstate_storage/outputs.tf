output "storage_account_id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.tfstate.id
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.tfstate.name
}

output "storage_account_primary_blob_endpoint" {
  description = "Primary blob endpoint of the storage account"
  value       = azurerm_storage_account.tfstate.primary_blob_endpoint
}

output "container_name" {
  description = "Name of the storage container"
  value       = azurerm_storage_container.tfstate.name
}

output "container_id" {
  description = "ID of the storage container"
  value       = azurerm_storage_container.tfstate.id
}
