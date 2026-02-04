# Azure Kubernetes Service (AKS) Module

This module creates a production-ready Azure Kubernetes Service cluster with comprehensive configuration options including multiple node pools, auto-scaling, monitoring, and security features.

## Features

- ✅ Azure CNI or Kubenet networking
- ✅ System and user node pools with auto-scaling
- ✅ Azure AD RBAC integration
- ✅ Log Analytics and Container Insights monitoring
- ✅ Azure Policy for Kubernetes
- ✅ Key Vault Secrets Provider integration
- ✅ Network policies (Azure, Calico, Cilium)
- ✅ Private cluster support
- ✅ ACR integration with automatic role assignment
- ✅ Availability zones support
- ✅ Custom auto-scaler profiles

## Prerequisites

1. **Resource Group**: Must exist before deployment
2. **Virtual Network & Subnet**: Required for AKS node deployment
3. **Log Analytics Workspace**: Recommended for monitoring (optional)
4. **Azure Container Registry**: Optional, for container image storage
5. **Azure AD Group**: Required if using Azure AD RBAC
6. **Service Principal**: With appropriate permissions

## Resources Created

- `azurerm_kubernetes_cluster`: AKS cluster with default node pool
- `azurerm_kubernetes_cluster_node_pool`: Additional node pools (optional)
- `azurerm_role_assignment`: ACR pull role (if ACR provided)

## Usage

### Basic AKS Cluster

```hcl
module "aks" {
  source = "./modules/aks"

  cluster_name        = "aks-prod"
  resource_group_name = "rg-aks"
  location            = "eastus"
  dns_prefix          = "aks-prod"
  vnet_subnet_id      = module.vnet.subnet_ids["aks-subnet"]

  default_node_pool = {
    name                = "system"
    node_count          = 3
    vm_size             = "Standard_D4s_v3"
    enable_auto_scaling = true
    min_count           = 2
    max_count           = 5
  }

  tags = {
    Environment = "Production"
  }
}
```

### Production AKS with Monitoring and ACR

```hcl
module "aks_production" {
  source = "./modules/aks"

  cluster_name        = "aks-prod"
  resource_group_name = module.resource_group.resource_group_name
  location            = "eastus"
  dns_prefix          = "aks-prod"
  kubernetes_version  = "1.28"
  sku_tier            = "Standard"
  vnet_subnet_id      = module.vnet.subnet_ids["aks-subnet"]

  # System Node Pool
  default_node_pool = {
    name                = "system"
    node_count          = 3
    vm_size             = "Standard_D4s_v3"
    enable_auto_scaling = true
    min_count           = 3
    max_count           = 6
    max_pods            = 110
    os_disk_size_gb     = 128
    availability_zones  = ["1", "2", "3"]
    node_labels = {
      "nodepool-type" = "system"
      "environment"   = "production"
    }
  }

  # Additional User Node Pools
  additional_node_pools = [
    {
      name                = "apps"
      vm_size             = "Standard_D8s_v3"
      enable_auto_scaling = true
      min_count           = 2
      max_count           = 10
      mode                = "User"
      node_labels = {
        "workload-type" = "applications"
      }
    }
  ]

  # Networking
  network_plugin = "azure"
  network_policy = "azure"
  service_cidr   = "10.240.0.0/16"
  dns_service_ip = "10.240.0.10"

  # Azure AD RBAC
  enable_azure_ad_rbac = true
  azure_rbac_enabled   = true
  admin_group_object_ids = [
    "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  ]

  # Monitoring
  log_analytics_workspace_id = module.log_analytics.workspace_id

  # Security
  enable_key_vault_secrets_provider = true
  enable_azure_policy              = true

  # ACR Integration
  acr_id = module.acr.registry_id

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}
```

### Private AKS Cluster

```hcl
module "aks_private" {
  source = "./modules/aks"

  cluster_name            = "aks-private"
  resource_group_name     = "rg-private-aks"
  location                = "eastus"
  dns_prefix              = "aks-private"
  private_cluster_enabled = true
  vnet_subnet_id          = module.vnet.subnet_ids["aks-subnet"]

  default_node_pool = {
    name                = "system"
    node_count          = 3
    vm_size             = "Standard_D4s_v3"
    enable_auto_scaling = true
    min_count           = 2
    max_count           = 5
  }

  network_plugin = "azure"
  network_policy = "azure"

  tags = {
    Environment = "Production"
    Visibility  = "Private"
  }
}
```

### Multi-Node Pool Configuration

```hcl
module "aks_multi_pool" {
  source = "./modules/aks"

  cluster_name        = "aks-multi"
  resource_group_name = "rg-aks"
  location            = "eastus"
  dns_prefix          = "aks-multi"
  vnet_subnet_id      = module.vnet.subnet_ids["aks-subnet"]

  # System Node Pool
  default_node_pool = {
    name                = "system"
    node_count          = 3
    vm_size             = "Standard_D2s_v3"
    enable_auto_scaling = true
    min_count           = 2
    max_count           = 5
  }

  # Additional Node Pools
  additional_node_pools = [
    # General applications
    {
      name                = "apps"
      vm_size             = "Standard_D4s_v3"
      enable_auto_scaling = true
      min_count           = 2
      max_count           = 10
      mode                = "User"
      node_labels = {
        "workload" = "general"
      }
    },
    # GPU workloads
    {
      name                = "gpu"
      vm_size             = "Standard_NC6s_v3"
      node_count          = 1
      enable_auto_scaling = false
      mode                = "User"
      node_labels = {
        "workload" = "gpu"
      }
      node_taints = [
        "sku=gpu:NoSchedule"
      ]
    },
    # Memory-optimized workloads
    {
      name                = "memory"
      vm_size             = "Standard_E8s_v3"
      enable_auto_scaling = true
      min_count           = 1
      max_count           = 5
      mode                = "User"
      node_labels = {
        "workload" = "memory-intensive"
      }
    }
  ]

  tags = {
    Environment = "Production"
  }
}
```

## Input Variables

### Required Variables

| Name | Description | Type |
|------|-------------|------|
| `cluster_name` | Name of the AKS cluster | `string` |
| `resource_group_name` | Resource group name | `string` |
| `location` | Azure region | `string` |
| `dns_prefix` | DNS prefix for the cluster | `string` |
| `vnet_subnet_id` | Subnet ID for AKS nodes | `string` |

### Cluster Configuration

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `kubernetes_version` | Kubernetes version | `string` | `null` (latest) |
| `sku_tier` | SKU tier (Free, Standard, Premium) | `string` | `"Free"` |
| `private_cluster_enabled` | Enable private cluster | `bool` | `false` |

### Node Pool Configuration

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `default_node_pool` | Default (system) node pool config | `object` | See variables.tf |
| `additional_node_pools` | Additional node pools | `list(object)` | `[]` |

### Networking

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `network_plugin` | Network plugin (azure, kubenet) | `string` | `"azure"` |
| `network_policy` | Network policy (azure, calico, cilium) | `string` | `"azure"` |
| `service_cidr` | Kubernetes service CIDR | `string` | `"10.240.0.0/16"` |
| `dns_service_ip` | DNS service IP | `string` | `"10.240.0.10"` |

### Security & Identity

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `identity_type` | Identity type (SystemAssigned, UserAssigned) | `string` | `"SystemAssigned"` |
| `enable_azure_ad_rbac` | Enable Azure AD RBAC | `bool` | `true` |
| `azure_rbac_enabled` | Enable Azure RBAC | `bool` | `true` |
| `admin_group_object_ids` | Azure AD admin group IDs | `list(string)` | `[]` |

### Monitoring & Add-ons

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `log_analytics_workspace_id` | Log Analytics workspace ID | `string` | `null` |
| `enable_key_vault_secrets_provider` | Enable Key Vault CSI driver | `bool` | `false` |
| `enable_azure_policy` | Enable Azure Policy | `bool` | `false` |

### ACR Integration

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `acr_id` | Azure Container Registry ID | `string` | `null` |

## Outputs

| Name | Description |
|------|-------------|
| `cluster_id` | AKS cluster ID |
| `cluster_name` | AKS cluster name |
| `cluster_fqdn` | Cluster FQDN |
| `kube_config` | Kubeconfig for kubectl (sensitive) |
| `cluster_identity_principal_id` | Cluster identity principal ID |
| `kubelet_identity_object_id` | Kubelet identity object ID |
| `node_resource_group` | Node resource group name |
| `oidc_issuer_url` | OIDC issuer URL |

## VM Size Recommendations

### System Node Pool
- **Small**: `Standard_D2s_v3` (2 vCPU, 8 GB RAM)
- **Medium**: `Standard_D4s_v3` (4 vCPU, 16 GB RAM) ✅ Recommended
- **Large**: `Standard_D8s_v3` (8 vCPU, 32 GB RAM)

### User Node Pools
- **General**: `Standard_D4s_v3`, `Standard_D8s_v3`
- **Memory-optimized**: `Standard_E4s_v3`, `Standard_E8s_v3`
- **Compute-optimized**: `Standard_F4s_v2`, `Standard_F8s_v2`
- **GPU**: `Standard_NC6s_v3`, `Standard_NC12s_v3`

## Network Plugin Comparison

| Feature | Azure CNI | Kubenet |
|---------|-----------|---------|
| Pod IPs | VNet IP addresses | NAT'd addresses |
| Network Policy | Full support | Limited support |
| Performance | Better | Good |
| IP consumption | Higher | Lower |
| Recommended for | Production | Dev/Test |

## SKU Tiers

- **Free**: No SLA, best for dev/test
- **Standard**: 99.95% SLA (zone), 99.9% (non-zone), recommended for production
- **Premium**: Enhanced security, 99.95% SLA

## Best Practices

1. **Use Standard SKU tier** for production workloads
2. **Enable auto-scaling** for flexible capacity
3. **Use availability zones** for high availability
4. **Separate system and user node pools** for better resource management
5. **Enable Azure AD RBAC** for secure access control
6. **Integrate with Log Analytics** for monitoring
7. **Use Azure CNI** for production workloads
8. **Enable network policies** for pod-to-pod security
9. **Configure ACR integration** for seamless image pulls
10. **Use node taints and labels** for workload placement control
11. **Enable Key Vault Secrets Provider** for secret management
12. **Set appropriate resource limits** on node pools

## Deployment Order

1. Resource Group
2. Virtual Network with AKS subnet
3. Log Analytics Workspace (optional but recommended)
4. Azure Container Registry (optional)
5. AKS Cluster

## Post-Deployment Steps

1. **Configure kubectl**:
   ```bash
   az aks get-credentials --resource-group <rg-name> --name <cluster-name>
   ```

2. **Verify cluster**:
   ```bash
   kubectl get nodes
   kubectl get pods --all-namespaces
   ```

3. **Install ingress controller** (if needed):
   ```bash
   helm install nginx-ingress ingress-nginx/ingress-nginx
   ```

4. **Configure monitoring dashboards** in Azure Portal

## Troubleshooting

- **Node provisioning fails**: Check subnet size and available IPs
- **Pods not starting**: Verify node pool capacity and resource limits
- **ACR pull fails**: Ensure AcrPull role is assigned to kubelet identity
- **Network policy issues**: Verify network plugin and policy compatibility
- **High costs**: Review node pool sizes and auto-scaling settings

## Security Considerations

- Enable Azure AD integration for identity management
- Use private cluster for sensitive workloads
- Implement network policies for pod-to-pod communication
- Enable Azure Policy for governance
- Use Key Vault for secrets management
- Regularly update Kubernetes version
- Implement pod security standards

## Cost Optimization

- Use appropriate VM sizes for workloads
- Enable auto-scaling to match demand
- Use spot instances for fault-tolerant workloads
- Implement pod resource limits
- Monitor and optimize node utilization
- Use Azure Hybrid Benefit if applicable
