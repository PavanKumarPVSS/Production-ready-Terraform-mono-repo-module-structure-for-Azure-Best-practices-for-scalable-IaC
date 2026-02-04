variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "app_insights_name" {
  description = "Name of the Application Insights instance"
  type        = string
}

variable "application_type" {
  description = "Application type for Application Insights"
  type        = string
  default     = "web"
}

variable "api_key_name" {
  description = "Name of the Application Insights API key"
  type        = string
}

variable "bot_name" {
  description = "Name of the Azure Bot"
  type        = string
}

variable "bot_location" {
  description = "Location for the Azure Bot (typically 'global')"
  type        = string
  default     = "global"
}

variable "bot_sku" {
  description = "SKU for the Azure Bot (F0 for free tier, S1 for standard)"
  type        = string
  default     = "F0"
}

variable "bot_endpoint" {
  description = "Bot messaging endpoint URL"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
