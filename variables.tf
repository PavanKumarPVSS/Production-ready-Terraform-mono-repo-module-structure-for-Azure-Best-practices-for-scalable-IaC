variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-example"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "development"
}

variable "storage_account_name" {
  description = "Name of the storage account for tfstate"
  type        = string
  default     = "tfstatestorage"
}

variable "container_name" {
  description = "Name of the blob container for tfstate"
  type        = string
  default     = "tfstate"
}
