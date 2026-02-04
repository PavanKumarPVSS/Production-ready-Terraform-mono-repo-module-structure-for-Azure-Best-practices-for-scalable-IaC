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

# App Service Variables
variable "service_plan_name" {
  description = "Name of the App Service Plan for bot"
  type        = string
  default     = "bot-service-plan"
}

variable "app_service_os_type" {
  description = "Operating system type for App Service (Linux or Windows)"
  type        = string
  default     = "Linux"
  validation {
    condition     = contains(["Linux", "Windows"], var.app_service_os_type)
    error_message = "OS type must be either Linux or Windows."
  }
}

variable "app_service_sku" {
  description = "SKU for the App Service Plan (F1 for free, B1 for basic)"
  type        = string
  default     = "F1"
  validation {
    condition     = contains(["F1", "B1", "B2", "B3", "S1", "S2", "S3"], var.app_service_sku)
    error_message = "SKU must be F1 (free), B1/B2/B3 (basic), or S1/S2/S3 (standard)."
  }
}

variable "web_app_name" {
  description = "Name of the Web App for bot"
  type        = string
  default     = "bot-web-app"
}

variable "node_version" {
  description = "Node.js version for the web app"
  type        = string
  default     = "18-lts"
}

# Azure Bot Variables
variable "bot_name" {
  description = "Name of the Azure Bot"
  type        = string
  default     = "example-azure-bot"
}

variable "bot_sku" {
  description = "SKU for the Azure Bot (F0 for free tier, S1 for standard)"
  type        = string
  default     = "F0"
  validation {
    condition     = contains(["F0", "S1"], var.bot_sku)
    error_message = "SKU must be F0 (free) or S1 (standard)."
  }
}

variable "app_insights_name" {
  description = "Name of the Application Insights instance for bot monitoring"
  type        = string
  default     = "bot-app-insights"
}

variable "app_insights_api_key_name" {
  description = "Name of the Application Insights API key"
  type        = string
  default     = "bot-app-insights-api-key"
}
