# Terraform Mono-Repo Module Structure (Production Ready)

![Terraform](https://img.shields.io/badge/Terraform-IaC-blueviolet)
![Azure](https://img.shields.io/badge/Azure-Cloud-blue)
![CI/CD](https://img.shields.io/badge/Azure%20DevOps-CI%2FCD-green)

A **scalable, production-ready Terraform mono-repo structure** designed for **Azure cloud deployments**, following **Terraform best practices** for reusable modules, multiple environments, and DevOps workflows.

This repository helps DevOps and Platform Engineers:
- Design clean Terraform folder structures
- Manage multiple environments (dev, test, prod)
- Reuse Terraform modules efficiently
- Avoid common Terraform anti-patterns

## Keywords

Terraform mono-repo, Terraform Azure modules, Azure DevOps Terraform pipeline,
Databricks Unity Catalog Terraform, Infrastructure as Code Azure,
Terraform CI/CD best practices, Azure landing zone Terraform

## Why this Terraform Mono-Repo Structure?

Many teams struggle with:
- How to structure Terraform repositories
- Managing multiple environments
- Sharing Terraform modules across projects
- Scaling Terraform without copy-paste

This repository provides a **real-world Terraform mono-repo pattern** used in enterprise DevOps environments.

## Repository Structure

This repository uses a **Terraform mono-repo pattern** with reusable modules, environment-specific configurations, and automated CI/CD pipelines for Azure:

```text
.
├── modules/                       # Reusable Terraform modules
│   ├── resource_group/           # Azure Resource Group module
│   │   └── README.md            # Module documentation
│   ├── tfstate_storage/          # Terraform state storage account
│   │   └── README.md            # Module documentation
│   ├── vnet/                     # Virtual Network with subnets and NSGs
│   │   └── README.md            # Module documentation
│   ├── databricks/               # Azure Databricks workspace with VNet injection
│   │   └── README.md            # Module documentation
│   ├── unity_catalog/            # Databricks Unity Catalog infrastructure
│   │   ├── README.md            # Module documentation
│   │   └── UNITY_CATALOG_SETUP.md  # Post-deployment setup guide
│   ├── app_service/              # App Service Plan and Web Apps (Linux/Windows)
│   │   └── README.md            # Module documentation
│   ├── azure_bot/                # Azure Bot Service with App Insights
│   │   └── README.md            # Module documentation
│   ├── storage_account/          # Generic Storage Account with containers/queues/tables
│   │   └── README.md            # Module documentation
│   └── key_vault/                # Key Vault with secrets, keys, and access policies
│       └── README.md            # Module documentation
├── environments/                  # Environment-specific configurations
│   ├── development.tfvars        # Development environment variables
│   ├── qa.tfvars                 # QA environment variables
│   └── production.tfvars         # Production environment variables
├── azure_pipelines/               # Azure DevOps pipeline definitions
│   ├── plan-pipeline.yaml        # Dev/QA validation and planning pipeline
│   ├── deployment-pipeline.yaml  # Production deployment with approval gates
│   └── README.md                 # Pipeline documentation
├── provider.tf                    # Provider configuration (AzureRM)
├── variables.tf                   # Global variable definitions
├── outputs.tf                     # Root outputs
├── main.tf                        # Main Terraform entrypoint (calls modules)
└── README.md                      # This documentation

## Use Cases

This repository is ideal for:
- Enterprise Terraform mono-repos
- Azure landing zones and cloud migrations
- Databricks deployments with Unity Catalog
- Bot development and AI workloads
- Platform engineering teams
- DevOps teams managing multiple subscriptions
- Multi-environment infrastructure (dev, test, prod)
- Infrastructure-as-Code at scale

## Available Modules

### Core Infrastructure
- **[resource_group](modules/resource_group/)** - Azure Resource Group management
- **[tfstate_storage](modules/tfstate_storage/)** - Remote state backend storage
- **[vnet](modules/vnet/)** - Virtual Network with subnets and NSGs
- **[storage_account](modules/storage_account/)** - Generic Storage Account with containers, queues, tables, and file shares
- **[key_vault](modules/key_vault/)** - Key Vault with secrets, keys, and access policies

### Data & Analytics
- **[databricks](modules/databricks/)** - Azure Databricks workspace with VNet injection
- **[unity_catalog](modules/unity_catalog/)** - Databricks Unity Catalog infrastructure

### Application Services
- **[app_service](modules/app_service/)** - App Service Plan and Web Apps (Linux/Windows support)
- **[azure_bot](modules/azure_bot/)** - Azure Bot Service with Application Insights monitoring

Each module includes:
- ✅ Complete `main.tf`, `variables.tf`, and `outputs.tf` files
- ✅ Comprehensive README with usage examples
- ✅ Prerequisites and deployment order documentation
- ✅ Input/output variable reference tables
- ✅ Best practices and validation rules

## Architecture Overview

This repository follows a layered Terraform architecture:

- **Foundation layer**: Resource groups, state storage, networking, Key Vault
- **Platform layer**: Databricks, Unity Catalog, shared storage
- **Application layer**: App Services and Azure Bot workloads

This separation improves reusability, governance, and environment isolation.

## Mono-Repo vs Multi-Repo Terraform

| Mono-Repo | Multi-Repo |
|----------|-----------|
| Centralized module management | Module duplication |
| Easier governance | Harder consistency |
| Better visibility | Fragmented ownership |

## Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed and authenticated
- Azure subscription with appropriate permissions
- Git for version control
- Azure DevOps account (for CI/CD pipelines)

### Quick Start

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd Terraform
   ```

2. **Authenticate with Azure**
   ```bash
   az login
   az account set --subscription "<your-subscription-id>"
   ```

3. **Choose your environment**
   
   Select the appropriate environment configuration:
   - `environments/development.tfvars` - Development environment
   - `environments/qa.tfvars` - QA environment
   - `environments/production.tfvars` - Production environment

4. **Update configuration**
   
   Edit the chosen tfvars file with your specific values:
   ```bash
   # For development
   nano environments/development.tfvars
   ```

5. **Initialize Terraform**
   ```bash
   terraform init
   ```

6. **Plan the deployment**
   ```bash
   # For development
   terraform plan -var-file="environments/development.tfvars"
   
   # For QA
   terraform plan -var-file="environments/qa.tfvars"
   
   # For production
   terraform plan -var-file="environments/production.tfvars"
   ```

7. **Apply the configuration**
   ```bash
   # For development
   terraform apply -var-file="environments/development.tfvars"
   ```

### Using CI/CD Pipelines

For automated deployments using Azure DevOps:

1. **Set up Azure DevOps**
   - See [azure_pipelines/README.md](azure_pipelines/README.md) for detailed setup instructions
   - Configure service connections and variable groups
   - Create environments for approval gates

2. **Run Plan Pipeline** (Dev & QA)
   - Use `azure_pipelines/plan-pipeline.yaml`
   - Validates and plans changes for Dev and QA environments
   - No manual approval required

3. **Run Deployment Pipeline** (Production)
   - Use `azure_pipelines/deployment-pipeline.yaml`
   - Includes approval gates before Plan and Apply stages
   - Deploys to production environment safely

## Deployment Order

For successful deployment, follow this order:

1. **Resource Group** - Base infrastructure container
2. **Terraform State Storage** - Remote backend setup
3. **Virtual Network** - Network infrastructure
4. **Storage Account / Key Vault** - Supporting services
5. **Databricks Workspace** - Depends on VNet
6. **Unity Catalog** - Depends on Resource Group (see post-deployment setup in [modules/unity_catalog/UNITY_CATALOG_SETUP.md](modules/unity_catalog/UNITY_CATALOG_SETUP.md))
7. **App Service** - Bot backend hosting
8. **Azure Bot** - Depends on App Service endpoint

## Environment Management

This repository supports multiple environments with isolated configurations:

### Environment Structure

```
environments/
├── development.tfvars  # Dev environment (Free/Basic SKUs, 10.0.0.0/16)
├── qa.tfvars          # QA environment (Basic/Standard SKUs, 10.1.0.0/16)
└── production.tfvars  # Production environment (Standard SKUs, 10.2.0.0/16)
```

### Environment Isolation

Each environment has:
- ✅ Separate resource names and prefixes
- ✅ Isolated VNet address spaces
- ✅ Independent Terraform state files
- ✅ Environment-appropriate SKUs and configurations
- ✅ Isolated deployment pipelines

### Switching Between Environments

```bash
# Deploy to development
terraform plan -var-file="environments/development.tfvars"
terraform apply -var-file="environments/development.tfvars"

# Deploy to QA
terraform plan -var-file="environments/qa.tfvars"
terraform apply -var-file="environments/qa.tfvars"

# Deploy to production
terraform plan -var-file="environments/production.tfvars"
terraform apply -var-file="environments/production.tfvars"
```

## CI/CD Pipeline Strategy

### Plan Pipeline (Dev & QA)
- Runs `init`, `validate`, and `plan` for Dev and QA
- No approval gates - automated validation
- Generates plan artifacts for review
- Pipeline: [azure_pipelines/plan-pipeline.yaml](azure_pipelines/plan-pipeline.yaml)

### Deployment Pipeline (Production)
- Complete workflow: `init` → `validate` → `plan` → `apply`
- **Two approval gates**:
  1. Before generating plan
  2. Before applying changes
- Uses Azure DevOps Environment "Production"
- Pipeline: [azure_pipelines/deployment-pipeline.yaml](azure_pipelines/deployment-pipeline.yaml)

### State File Isolation

Each environment uses a dedicated state file:
- Development: `dev-terraform.tfstate`
- QA: `qa-terraform.tfstate`
- Production: `prod-terraform.tfstate`

This prevents cross-environment interference and allows safe parallel deployments.

## Module Usage Examples

### Deploy Databricks with Unity Catalog

```hcl
# Resource Group
module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = "rg-databricks-prod"
  location            = "East US"
}

# VNet for Databricks
module "databricks_vnet" {
  source              = "./modules/vnet"
  vnet_name           = "vnet-databricks"
  resource_group_name = module.resource_group.resource_group_name
  location            = "East US"
  address_space       = ["10.0.0.0/16"]
  # ... subnet configuration
}

# Databricks Workspace
module "databricks" {
  source              = "./modules/databricks"
  workspace_name      = "dbw-prod"
  resource_group_name = module.resource_group.resource_group_name
  virtual_network_id  = module.databricks_vnet.vnet_id
  # ... additional configuration
}

# Unity Catalog
module "unity_catalog" {
  source                = "./modules/unity_catalog"
  access_connector_name = "dbw-unity-connector"
  storage_account_name  = "unitycatalogstore"
  # ... additional configuration
}
```

### Deploy Azure Bot with App Service

```hcl
# App Service for Bot Backend
module "bot_app_service" {
  source            = "./modules/app_service"
  service_plan_name = "bot-service-plan"
  os_type           = "Linux"
  web_app_name      = "my-bot-app"
  # ... additional configuration
}

# Azure Bot Service
module "azure_bot" {
  source        = "./modules/azure_bot"
  bot_name      = "my-chatbot"
  bot_endpoint  = module.bot_app_service.bot_endpoint
  # ... additional configuration
}
```

## Best Practices

### Module Design
- ✅ Keep modules focused and single-purpose
- ✅ Use variables for all configurable values
- ✅ Include comprehensive validation rules
- ✅ Document prerequisites and dependencies
- ✅ Export useful outputs for module consumers

### Security
- 🔒 Store sensitive values in Azure Key Vault
- 🔒 Use managed identities where possible
- 🔒 Enable network restrictions on storage and Key Vault
- 🔒 Never commit secrets to version control
- 🔒 Use HTTPS and latest TLS versions

### State Management
- 💾 Use remote state backend (Azure Storage)
- 💾 Enable state locking
- 💾 Use separate state files per environment
- 💾 Regular state backups

## CI/CD Integration

This repository includes comprehensive Azure DevOps pipelines in the `azure_pipelines/` folder:

### Pipeline Architecture

**Plan Pipeline** ([plan-pipeline.yaml](azure_pipelines/plan-pipeline.yaml))
- Validates and plans Dev and QA environments
- Automated execution without approval gates
- Generates plan artifacts for review
- Runs on: Pull requests and manual triggers

**Deployment Pipeline** ([deployment-pipeline.yaml](azure_pipelines/deployment-pipeline.yaml))
- Full deployment workflow for Production
- Two-stage approval process:
  - Manual approval before `terraform plan`
  - Manual approval before `terraform apply`
- Uses Azure DevOps Environment "Production"
- Runs on: Manual triggers only

### Required Azure DevOps Setup

1. **Service Connection**: `terraformdeployement` (Azure Resource Manager)
2. **Variable Group**: `TFstate-variables` with backend configuration
3. **Agent Pool**: `Agent` with Terraform CLI installed
4. **Environment**: `Production` with approval gates configured

See [azure_pipelines/README.md](azure_pipelines/README.md) for complete setup instructions.

### Pipeline Features

- ✅ Environment-specific state files (dev-, qa-, prod- prefixes)
- ✅ Plan artifacts published for review before apply
- ✅ Manual validation checkpoints for production safety
- ✅ Automated validation for non-production environments
- ✅ Integration with Azure DevOps Environments for tracking

## Project Structure Benefits

### ✅ Modular Design
- Reusable modules across environments
- Single source of truth for infrastructure patterns
- Easy to test and validate modules independently

### ✅ Environment Separation
- Dedicated tfvars files per environment
- Isolated state files prevent cross-environment issues
- Different SKUs and configurations per environment

### ✅ Safety & Governance
- Approval gates for production deployments
- Automated validation prevents configuration errors
- Pipeline artifacts provide audit trail

### ✅ Developer Experience
- Clear folder structure
- Comprehensive documentation
- Easy to onboard new team members

## Contributing

1. Create a feature branch
2. Make your changes
3. Update module README if needed
4. Test with development environment first
5. Run plan pipeline to validate changes
6. Submit a pull request


## Additional Resources

- **Module Documentation**: Each module has its own README with usage examples
- **Pipeline Setup**: See [azure_pipelines/README.md](azure_pipelines/README.md)
- **Unity Catalog Setup**: See [modules/unity_catalog/UNITY_CATALOG_SETUP.md](modules/unity_catalog/UNITY_CATALOG_SETUP.md)
- **Terraform Best Practices**: Refer to individual module READMEs

## Support

For issues, questions, or contributions, please open an issue in the repository.

---

**Disclaimer**: 
> This repository demonstrates production-grade Terraform patterns.
> Adapt naming conventions and security controls to meet your organization's standards.