# AKS Module Outputs

output "cluster_id" {
  description = "ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "cluster_name" {
  description = "Name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "cluster_fqdn" {
  description = "FQDN of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.fqdn
}

output "kube_config" {
  description = "Kubernetes configuration for kubectl"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "kube_config_object" {
  description = "Kubernetes configuration object"
  value       = azurerm_kubernetes_cluster.aks.kube_config
  sensitive   = true
}

output "cluster_identity_principal_id" {
  description = "Principal ID of the cluster's managed identity"
  value       = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}

output "cluster_identity_tenant_id" {
  description = "Tenant ID of the cluster's managed identity"
  value       = azurerm_kubernetes_cluster.aks.identity[0].tenant_id
}

output "kubelet_identity_object_id" {
  description = "Object ID of the kubelet identity"
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

output "kubelet_identity_client_id" {
  description = "Client ID of the kubelet identity"
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity[0].client_id
}

output "node_resource_group" {
  description = "Resource group containing AKS nodes"
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "oidc_issuer_url" {
  description = "OIDC issuer URL"
  value       = azurerm_kubernetes_cluster.aks.oidc_issuer_url
}

output "portal_fqdn" {
  description = "FQDN for the Azure Portal"
  value       = azurerm_kubernetes_cluster.aks.portal_fqdn
}

output "additional_node_pool_ids" {
  description = "IDs of additional node pools"
  value       = { for k, v in azurerm_kubernetes_cluster_node_pool.additional : k => v.id }
}

output "kubernetes_version" {
  description = "Current Kubernetes version"
  value       = azurerm_kubernetes_cluster.aks.kubernetes_version
}
