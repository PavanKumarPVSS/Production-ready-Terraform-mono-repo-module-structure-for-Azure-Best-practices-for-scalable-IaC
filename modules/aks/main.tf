# Azure Kubernetes Service (AKS) Module

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  private_cluster_enabled = var.private_cluster_enabled
  sku_tier               = var.sku_tier

  # Default Node Pool (System)
  default_node_pool {
    name           = var.default_node_pool.name
    node_count     = var.default_node_pool.enable_auto_scaling ? null : var.default_node_pool.node_count
    vm_size        = var.default_node_pool.vm_size
    vnet_subnet_id = var.vnet_subnet_id
    
    auto_scaling_enabled = var.default_node_pool.enable_auto_scaling
    min_count            = var.default_node_pool.enable_auto_scaling ? var.default_node_pool.min_count : null
    max_count            = var.default_node_pool.enable_auto_scaling ? var.default_node_pool.max_count : null
    
    max_pods        = var.default_node_pool.max_pods
    os_disk_size_gb = var.default_node_pool.os_disk_size_gb
    type            = "VirtualMachineScaleSets"
    zones           = var.default_node_pool.availability_zones

    node_labels = var.default_node_pool.node_labels

    tags = var.tags
  }

  # Identity
  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : null
  }

  # Network Profile
  network_profile {
    network_plugin     = var.network_plugin
    network_policy     = var.network_policy
    dns_service_ip     = var.dns_service_ip
    service_cidr       = var.service_cidr
    load_balancer_sku  = "standard"
    outbound_type      = var.outbound_type
  }

  # Azure AD Integration
  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.enable_azure_ad_rbac ? [1] : []
    content {
      azure_rbac_enabled     = var.azure_rbac_enabled
      admin_group_object_ids = var.admin_group_object_ids
    }
  }

  # OMS Agent (Log Analytics)
  dynamic "oms_agent" {
    for_each = var.log_analytics_workspace_id != null ? [1] : []
    content {
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  # Key Vault Secrets Provider
  dynamic "key_vault_secrets_provider" {
    for_each = var.enable_key_vault_secrets_provider ? [1] : []
    content {
      secret_rotation_enabled  = var.secret_rotation_enabled
      secret_rotation_interval = var.secret_rotation_interval
    }
  }

  # Azure Policy
  azure_policy_enabled = var.enable_azure_policy

  # HTTP Application Routing (not recommended for production)
  http_application_routing_enabled = var.enable_http_application_routing

  # Role Based Access Control
  role_based_access_control_enabled = true

  # Auto Scaler Profile
  dynamic "auto_scaler_profile" {
    for_each = var.auto_scaler_profile_enabled ? [1] : []
    content {
      balance_similar_node_groups      = var.auto_scaler_profile.balance_similar_node_groups
      expander                         = var.auto_scaler_profile.expander
      max_graceful_termination_sec     = var.auto_scaler_profile.max_graceful_termination_sec
      max_node_provisioning_time       = var.auto_scaler_profile.max_node_provisioning_time
      max_unready_nodes                = var.auto_scaler_profile.max_unready_nodes
      max_unready_percentage           = var.auto_scaler_profile.max_unready_percentage
      new_pod_scale_up_delay           = var.auto_scaler_profile.new_pod_scale_up_delay
      scale_down_delay_after_add       = var.auto_scaler_profile.scale_down_delay_after_add
      scale_down_delay_after_delete    = var.auto_scaler_profile.scale_down_delay_after_delete
      scale_down_delay_after_failure   = var.auto_scaler_profile.scale_down_delay_after_failure
      scan_interval                    = var.auto_scaler_profile.scan_interval
      scale_down_unneeded              = var.auto_scaler_profile.scale_down_unneeded
      scale_down_unready               = var.auto_scaler_profile.scale_down_unready
      scale_down_utilization_threshold = var.auto_scaler_profile.scale_down_utilization_threshold
      empty_bulk_delete_max            = var.auto_scaler_profile.empty_bulk_delete_max
      skip_nodes_with_local_storage    = var.auto_scaler_profile.skip_nodes_with_local_storage
      skip_nodes_with_system_pods      = var.auto_scaler_profile.skip_nodes_with_system_pods
    }
  }

  tags = var.tags
}

# Additional Node Pools
resource "azurerm_kubernetes_cluster_node_pool" "additional" {
  for_each = { for np in var.additional_node_pools : np.name => np }

  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = each.value.vm_size
  vnet_subnet_id        = var.vnet_subnet_id

  auto_scaling_enabled = each.value.enable_auto_scaling
  node_count           = each.value.enable_auto_scaling ? null : each.value.node_count
  min_count            = each.value.enable_auto_scaling ? each.value.min_count : null
  max_count            = each.value.enable_auto_scaling ? each.value.max_count : null

  max_pods        = each.value.max_pods
  os_disk_size_gb = each.value.os_disk_size_gb
  os_type         = each.value.os_type
  mode            = each.value.mode
  zones           = each.value.availability_zones

  node_labels = each.value.node_labels
  node_taints = each.value.node_taints

  tags = var.tags
}

# Role Assignment for ACR
resource "azurerm_role_assignment" "aks_acr" {
  count                = var.acr_id != null ? 1 : 0
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = var.acr_id
}
