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

# Databricks VNet Variables
variable "databricks_vnet_name" {
  description = "Name of the VNet for Databricks"
  type        = string
  default     = "databricks-vnet"
}

variable "vnet_address_space" {
  description = "Address space for the VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "databricks_public_subnet_name" {
  description = "Name of the public subnet for Databricks"
  type        = string
  default     = "databricks-public-subnet"
}

variable "databricks_private_subnet_name" {
  description = "Name of the private subnet for Databricks"
  type        = string
  default     = "databricks-private-subnet"
}

variable "public_subnet_prefix" {
  description = "Address prefix for public subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "private_subnet_prefix" {
  description = "Address prefix for private subnet"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

# Databricks Workspace Variables
variable "databricks_workspace_name" {
  description = "Name of the Databricks workspace"
  type        = string
  default     = "databricks-workspace"
}

variable "databricks_sku" {
  description = "SKU for Databricks workspace"
  type        = string
  default     = "premium"
  validation {
    condition     = contains(["standard", "premium", "trial"], var.databricks_sku)
    error_message = "SKU must be standard, premium, or trial."
  }
}

variable "databricks_public_access" {
  description = "Enable public network access to Databricks"
  type        = bool
  default     = false
}

variable "databricks_no_public_ip" {
  description = "Use Secure Cluster Connectivity (no public IPs)"
  type        = bool
  default     = true
}

# Unity Catalog Variables
variable "unity_catalog_access_connector_name" {
  description = "Name of the Databricks Access Connector for Unity Catalog"
  type        = string
  default     = "databricks-access-connector"
}

variable "unity_catalog_storage_account_name" {
  description = "Name of the storage account for Unity Catalog"
  type        = string
}

variable "unity_catalog_container_name" {
  description = "Name of the container for Unity Catalog metastore"
  type        = string
  default     = "unity-catalog"
}
