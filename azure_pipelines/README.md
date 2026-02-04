# Azure Pipelines

This folder contains Azure DevOps pipeline definitions for Terraform infrastructure deployment.

## Pipeline Files

### 1. plan-pipeline.yaml

**Purpose**: Validates and plans infrastructure changes for Development and QA environments.

**Stages**:
- **Dev_Validate**: Initialize and validate Terraform configuration for Dev
- **Dev_Plan**: Generate execution plan for Dev environment using `environments/development.tfvars`
- **QA_Validate**: Initialize and validate Terraform configuration for QA
- **QA_Plan**: Generate execution plan for QA environment using `environments/qa.tfvars`

**Usage**: Run this pipeline to review planned changes before applying them to Dev/QA environments.

### 2. deployment-pipeline.yaml

**Purpose**: Complete deployment workflow for Production environment with approval gates.

**Stages**:
- **Prod_Validate**: Initialize and validate Terraform configuration
- **Prod_Plan**: Generate execution plan (requires manual approval)
- **Prod_Apply**: Apply infrastructure changes (requires manual approval)

**Approval Gates**:
- ✅ Manual approval required before executing Plan
- ✅ Manual approval required before executing Apply
- ✅ Uses Azure DevOps Environment "Production" for tracking

**Usage**: Run this pipeline for production deployments with built-in safety checks.

## Prerequisites

### Azure DevOps Setup

1. **Service Connection**
   - Create Azure Resource Manager service connection named `terraformdeployement`
   - Grant necessary permissions for resource management

2. **Variable Group**
   - Create variable group named `TFstate-variables`
   - Add the following variables:
     - `tfstate_resource_group_name`: Resource group for state storage
     - `tfstate_storage_account_name`: Storage account for state files
     - `tfstate_container_name`: Container name (e.g., "tfstate")
     - `tfstate_key`: State file name (e.g., "terraform.tfstate")

3. **Agent Pool**
   - Configure agent pool named `Agent`
   - Ensure agents have Terraform CLI installed

4. **Environment**
   - Create environment named `Production` in Azure DevOps
   - Configure approvers for production deployments

## Backend Configuration

Each environment uses a separate state file:
- **Development**: `dev-terraform.tfstate`
- **QA**: `qa-terraform.tfstate`
- **Production**: `prod-terraform.tfstate`

This isolation prevents environment interference and allows independent infrastructure management.

## Pipeline Execution Flow

### Plan Pipeline (Dev & QA)
```
Dev_Validate → Dev_Plan → QA_Validate → QA_Plan
```

### Deployment Pipeline (Production)
```
Prod_Validate → [Approval] → Prod_Plan → [Approval] → Prod_Apply
```

## Setting Up Pipelines in Azure DevOps

1. Navigate to Pipelines → Create Pipeline
2. Select your repository
3. Choose "Existing Azure Pipelines YAML file"
4. Select the appropriate pipeline file:
   - `azure_pipelines/plan-pipeline.yaml`
   - `azure_pipelines/deployment-pipeline.yaml`
5. Save or run the pipeline

## Best Practices

- ✅ Always review plan outputs before approving
- ✅ Use plan pipeline for Dev/QA to verify changes
- ✅ Only use deployment pipeline for Production
- ✅ Keep separate state files for each environment
- ✅ Configure branch policies to trigger plan pipeline on PRs
- ✅ Restrict production pipeline execution to specific users/groups

## Customization

### Changing Service Connection
Update `azureSubscription` value in pipeline YAML files:
```yaml
azureSubscription: 'your-service-connection-name'
```

### Adding More Environments
1. Create new tfvars file in `environments/` folder
2. Add new stages to plan-pipeline.yaml
3. Update state file key naming convention

### Modifying Agent Pool
Update `pool.name` in pipeline YAML files:
```yaml
pool:
  name: 'YourAgentPoolName'
```
