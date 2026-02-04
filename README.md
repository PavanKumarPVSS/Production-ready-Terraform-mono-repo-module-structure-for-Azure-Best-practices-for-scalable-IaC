# Terraform Mono-Repo Module Structure (Production Ready)

A **scalable, production-ready Terraform mono-repo structure** designed for **Azure cloud deployments**, following **Terraform best practices** for reusable modules, multiple environments, and DevOps workflows.

This repository helps DevOps and Platform Engineers:
- Design clean Terraform folder structures
- Manage multiple environments (dev, test, prod)
- Reuse Terraform modules efficiently
- Avoid common Terraform anti-patterns

## Why this Terraform Mono-Repo Structure?

Many teams struggle with:
- How to structure Terraform repositories
- Managing multiple environments
- Sharing Terraform modules across projects
- Scaling Terraform without copy-paste

This repository provides a **real-world Terraform mono-repo pattern** used in enterprise DevOps environments.

## Repository Structure

This repository uses a **Terraform mono-repo pattern** with reusable modules and shared configurations for Azure:

```text
.
├── modules/                       # Reusable Terraform modules
│   ├── <module1>/                # e.g., networking module
│   ├── <module2>/                # e.g., compute or AKS module
│   └── … 
├── provider.tf                   # Provider configuration (AzureRM)
├── variables.tf                  # Global variable definitions
├── terraform.tfvars              # Default variable values
├── outputs.tf                    # Root outputs
├── mani.tf                       # Main Terraform entrypoint (calls modules)
├── azure-pipelines.yaml          # Azure DevOps CI/CD pipeline config
├── UNITY_CATALOG_SETUP.md        # Documentation for specific deployment use-case
└── README.md                    # This documentation

## Use Cases

This repository is ideal for:
- Enterprise Terraform mono-repos
- Azure landing zones
- Platform engineering teams
- DevOps teams managing multiple subscriptions
- Infrastructure-as-Code at scale

## Mono-Repo vs Multi-Repo Terraform

| Mono-Repo | Multi-Repo |
|----------|-----------|
| Centralized module management | Module duplication |
| Easier governance | Harder consistency |
| Better visibility | Fragmented ownership |