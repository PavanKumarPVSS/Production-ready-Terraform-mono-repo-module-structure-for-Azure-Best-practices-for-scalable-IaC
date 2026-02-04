variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "os_type" {
  description = "Operating system type (Linux or Windows)"
  type        = string
  default     = "Linux"
  validation {
    condition     = contains(["Linux", "Windows"], var.os_type)
    error_message = "OS type must be either Linux or Windows."
  }
}

variable "sku_name" {
  description = "SKU for the App Service Plan (F1 for free, B1 for basic)"
  type        = string
  default     = "F1"
  validation {
    condition     = contains(["F1", "B1", "B2", "B3", "S1", "S2", "S3"], var.sku_name)
    error_message = "SKU must be F1 (free), B1/B2/B3 (basic), or S1/S2/S3 (standard)."
  }
}

variable "web_app_name" {
  description = "Name of the Web App"
  type        = string
}

variable "node_version" {
  description = "Node.js version for the web app"
  type        = string
  default     = "18-lts"
}

variable "windows_current_stack" {
  description = "Current stack for Windows web app (node, dotnet, java, php, python)"
  type        = string
  default     = "node"
}

variable "dotnet_version" {
  description = ".NET version for Windows web app"
  type        = string
  default     = "v8.0"
}

variable "java_version" {
  description = "Java version for Windows web app"
  type        = string
  default     = "17"
}

variable "php_version" {
  description = "PHP version for Windows web app"
  type        = string
  default     = "8.2"
}

variable "python_version" {
  description = "Python version for Windows web app"
  type        = string
  default     = "3.11"
}

variable "app_settings" {
  description = "Application settings for the web app"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
