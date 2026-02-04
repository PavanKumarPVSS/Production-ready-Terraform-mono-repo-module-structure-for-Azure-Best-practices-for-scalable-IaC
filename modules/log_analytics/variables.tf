# Log Analytics Workspace Variables

variable "workspace_name" {
  description = "Name of the Log Analytics Workspace"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the workspace"
  type        = string
}

variable "sku" {
  description = "SKU of the Log Analytics Workspace (PerGB2018, CapacityReservation, etc.)"
  type        = string
  default     = "PerGB2018"

  validation {
    condition     = contains(["Free", "PerNode", "Premium", "Standard", "Standalone", "Unlimited", "CapacityReservation", "PerGB2018"], var.sku)
    error_message = "SKU must be one of: Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, PerGB2018"
  }
}

variable "retention_in_days" {
  description = "The workspace data retention in days (30-730 days, or 7 for Free tier)"
  type        = number
  default     = 30

  validation {
    condition     = (var.retention_in_days >= 30 && var.retention_in_days <= 730) || var.retention_in_days == 7
    error_message = "Retention must be between 30-730 days, or 7 days for Free tier"
  }
}

variable "daily_quota_gb" {
  description = "Daily ingestion limit in GB. -1 for unlimited"
  type        = number
  default     = -1
}

variable "internet_ingestion_enabled" {
  description = "Should the Log Analytics Workspace support ingestion over the Public Internet"
  type        = bool
  default     = true
}

variable "internet_query_enabled" {
  description = "Should the Log Analytics Workspace support querying over the Public Internet"
  type        = bool
  default     = true
}

variable "solutions" {
  description = "List of solutions to enable (ContainerInsights, SecurityCenterFree, etc.)"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
