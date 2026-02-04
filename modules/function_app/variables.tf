# Function App Module Variables

variable "function_app_name" {
  description = "Name of the Function App"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

# Storage Account Variables
variable "storage_account_name" {
  description = "Name of the storage account for Function App (required)"
  type        = string
}

variable "storage_account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "storage_account_replication_type" {
  description = "Storage account replication type"
  type        = string
  default     = "LRS"
}

# App Service Plan Variables
variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "os_type" {
  description = "Operating system type (Linux or Windows)"
  type        = string
  default     = "Linux"

  validation {
    condition     = contains(["Linux", "Windows"], var.os_type)
    error_message = "os_type must be either 'Linux' or 'Windows'"
  }
}

variable "sku_name" {
  description = "SKU name for App Service Plan (Y1 for Consumption, EP1/EP2/EP3 for Premium, S1/S2/S3/P1V2/P2V2/P3V2 for Dedicated)"
  type        = string
  default     = "Y1"
}

# Runtime Configuration
variable "runtime_name" {
  description = "Runtime stack name (dotnet, dotnet-isolated, node, python, java, powershell)"
  type        = string
  default     = null
}

variable "runtime_version" {
  description = "Runtime version (e.g., 8.0 for .NET, 20 for Node.js, 3.11 for Python)"
  type        = string
  default     = null
}

# Application Insights Variables
variable "enable_application_insights" {
  description = "Enable Application Insights for monitoring"
  type        = bool
  default     = true
}

variable "application_insights_name" {
  description = "Name of Application Insights resource"
  type        = string
  default     = ""
}

variable "application_insights_type" {
  description = "Application Insights application type"
  type        = string
  default     = "web"
}

# Function App Configuration
variable "always_on" {
  description = "Should the Function App be always on (not available for Consumption plan)"
  type        = bool
  default     = false
}

variable "https_only" {
  description = "Force HTTPS only traffic"
  type        = bool
  default     = true
}

variable "app_settings" {
  description = "Map of app settings for the Function App"
  type        = map(string)
  default     = {}
}

# CORS Configuration
variable "cors_allowed_origins" {
  description = "List of allowed origins for CORS"
  type        = list(string)
  default     = []
}

variable "cors_support_credentials" {
  description = "Are credentials supported for CORS"
  type        = bool
  default     = false
}

# Identity Configuration
variable "identity_type" {
  description = "Type of Managed Identity (SystemAssigned, UserAssigned, or SystemAssigned, UserAssigned)"
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "List of User Assigned Identity IDs"
  type        = list(string)
  default     = null
}

# Tags
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
