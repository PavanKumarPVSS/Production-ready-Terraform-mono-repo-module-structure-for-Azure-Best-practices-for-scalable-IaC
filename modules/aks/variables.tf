# AKS Module Variables

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix specified when creating the managed cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version to use for the AKS cluster"
  type        = string
  default     = null
}

variable "sku_tier" {
  description = "SKU tier for the AKS cluster (Free, Standard, Premium)"
  type        = string
  default     = "Free"

  validation {
    condition     = contains(["Free", "Standard", "Premium"], var.sku_tier)
    error_message = "SKU tier must be Free, Standard, or Premium"
  }
}

variable "private_cluster_enabled" {
  description = "Enable private cluster"
  type        = bool
  default     = false
}

# Default Node Pool Configuration
variable "default_node_pool" {
  description = "Default node pool configuration"
  type = object({
    name                = string
    node_count          = number
    vm_size             = string
    enable_auto_scaling = bool
    min_count           = optional(number, 1)
    max_count           = optional(number, 3)
    max_pods            = optional(number, 110)
    os_disk_size_gb     = optional(number, 128)
    availability_zones  = optional(list(string), ["1", "2", "3"])
    node_labels         = optional(map(string), {})
    node_taints         = optional(list(string), [])
  })
  default = {
    name                = "system"
    node_count          = 2
    vm_size             = "Standard_D2s_v3"
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 3
    max_pods            = 110
    os_disk_size_gb     = 128
    availability_zones  = ["1", "2", "3"]
    node_labels         = {}
    node_taints         = []
  }
}

# Additional Node Pools
variable "additional_node_pools" {
  description = "Additional node pools configuration"
  type = list(object({
    name                = string
    vm_size             = string
    node_count          = optional(number, 1)
    enable_auto_scaling = optional(bool, false)
    min_count           = optional(number, 1)
    max_count           = optional(number, 3)
    max_pods            = optional(number, 110)
    os_disk_size_gb     = optional(number, 128)
    os_type             = optional(string, "Linux")
    mode                = optional(string, "User")
    availability_zones  = optional(list(string), ["1", "2", "3"])
    node_labels         = optional(map(string), {})
    node_taints         = optional(list(string), [])
  }))
  default = []
}

# Network Configuration
variable "vnet_subnet_id" {
  description = "ID of the subnet for AKS nodes"
  type        = string
}

variable "network_plugin" {
  description = "Network plugin to use (azure, kubenet, none)"
  type        = string
  default     = "azure"

  validation {
    condition     = contains(["azure", "kubenet", "none"], var.network_plugin)
    error_message = "Network plugin must be azure, kubenet, or none"
  }
}

variable "network_policy" {
  description = "Network policy to use (azure, calico, cilium)"
  type        = string
  default     = "azure"

  validation {
    condition     = contains(["azure", "calico", "cilium"], var.network_policy)
    error_message = "Network policy must be azure, calico, or cilium"
  }
}

variable "service_cidr" {
  description = "CIDR used by Kubernetes services"
  type        = string
  default     = "10.240.0.0/16"
}

variable "dns_service_ip" {
  description = "IP address within the Kubernetes service CIDR for DNS"
  type        = string
  default     = "10.240.0.10"
}

variable "outbound_type" {
  description = "Outbound (egress) routing method (loadBalancer, userDefinedRouting, managedNATGateway, userAssignedNATGateway)"
  type        = string
  default     = "loadBalancer"
}

# Identity
variable "identity_type" {
  description = "Type of identity (SystemAssigned, UserAssigned)"
  type        = string
  default     = "SystemAssigned"

  validation {
    condition     = contains(["SystemAssigned", "UserAssigned"], var.identity_type)
    error_message = "Identity type must be SystemAssigned or UserAssigned"
  }
}

variable "identity_ids" {
  description = "List of User Assigned Identity IDs"
  type        = list(string)
  default     = null
}

# Azure AD RBAC
variable "enable_azure_ad_rbac" {
  description = "Enable Azure AD RBAC for Kubernetes authorization"
  type        = bool
  default     = true
}

variable "azure_rbac_enabled" {
  description = "Enable Azure RBAC for Kubernetes authorization"
  type        = bool
  default     = true
}

variable "admin_group_object_ids" {
  description = "List of Azure AD group object IDs for cluster admin access"
  type        = list(string)
  default     = []
}

# Monitoring
variable "log_analytics_workspace_id" {
  description = "ID of Log Analytics Workspace for monitoring"
  type        = string
  default     = null
}

# Key Vault Secrets Provider
variable "enable_key_vault_secrets_provider" {
  description = "Enable Key Vault Secrets Provider"
  type        = bool
  default     = false
}

variable "secret_rotation_enabled" {
  description = "Enable secret rotation"
  type        = bool
  default     = true
}

variable "secret_rotation_interval" {
  description = "Secret rotation interval (e.g., 2m)"
  type        = string
  default     = "2m"
}

# Azure Policy
variable "enable_azure_policy" {
  description = "Enable Azure Policy for Kubernetes"
  type        = bool
  default     = false
}

# HTTP Application Routing (not recommended for production)
variable "enable_http_application_routing" {
  description = "Enable HTTP Application Routing (not recommended for production)"
  type        = bool
  default     = false
}

# Auto Scaler Profile
variable "auto_scaler_profile_enabled" {
  description = "Enable custom auto scaler profile"
  type        = bool
  default     = false
}

variable "auto_scaler_profile" {
  description = "Auto scaler profile configuration"
  type = object({
    balance_similar_node_groups      = optional(bool, false)
    expander                         = optional(string, "random")
    max_graceful_termination_sec     = optional(number, 600)
    max_node_provisioning_time       = optional(string, "15m")
    max_unready_nodes                = optional(number, 3)
    max_unready_percentage           = optional(number, 45)
    new_pod_scale_up_delay           = optional(string, "10s")
    scale_down_delay_after_add       = optional(string, "10m")
    scale_down_delay_after_delete    = optional(string, "10s")
    scale_down_delay_after_failure   = optional(string, "3m")
    scan_interval                    = optional(string, "10s")
    scale_down_unneeded              = optional(string, "10m")
    scale_down_unready               = optional(string, "20m")
    scale_down_utilization_threshold = optional(number, 0.5)
    empty_bulk_delete_max            = optional(number, 10)
    skip_nodes_with_local_storage    = optional(bool, true)
    skip_nodes_with_system_pods      = optional(bool, true)
  })
  default = {
    balance_similar_node_groups      = false
    expander                         = "random"
    max_graceful_termination_sec     = 600
    max_node_provisioning_time       = "15m"
    max_unready_nodes                = 3
    max_unready_percentage           = 45
    new_pod_scale_up_delay           = "10s"
    scale_down_delay_after_add       = "10m"
    scale_down_delay_after_delete    = "10s"
    scale_down_delay_after_failure   = "3m"
    scan_interval                    = "10s"
    scale_down_unneeded              = "10m"
    scale_down_unready               = "20m"
    scale_down_utilization_threshold = 0.5
    empty_bulk_delete_max            = 10
    skip_nodes_with_local_storage    = true
    skip_nodes_with_system_pods      = true
  }
}

# ACR Integration
variable "acr_id" {
  description = "Azure Container Registry ID for ACR pull role assignment"
  type        = string
  default     = null
}

# Tags
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
