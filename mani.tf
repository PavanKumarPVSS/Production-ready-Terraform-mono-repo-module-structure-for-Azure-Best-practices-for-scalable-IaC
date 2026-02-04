# Resource Group Module
module "resource_group" {
  source = "./modules/resource_group"

  resource_group_name = var.resource_group_name
  location            = var.location

  tags = {
    environment = var.environment
    managed_by  = "terraform"
  }
}

# Terraform State Storage Module
module "tfstate_storage" {
  source = "./modules/tfstate_storage"

  storage_account_name = var.storage_account_name
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  container_name       = var.container_name

  tags = {
    environment = var.environment
    managed_by  = "terraform"
    purpose     = "tfstate"
  }

  depends_on = [module.resource_group]
}

# VNet Module for Databricks
module "databricks_vnet" {
  source = "./modules/vnet"

  vnet_name           = var.databricks_vnet_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  address_space       = var.vnet_address_space

  public_subnet_name    = var.databricks_public_subnet_name
  private_subnet_name   = var.databricks_private_subnet_name
  public_subnet_prefix  = var.public_subnet_prefix
  private_subnet_prefix = var.private_subnet_prefix

  tags = {
    environment = var.environment
    managed_by  = "terraform"
    purpose     = "databricks-networking"
  }
}

# Databricks Workspace Module
module "databricks_workspace" {
  source = "./modules/databricks"

  workspace_name      = var.databricks_workspace_name
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  sku                 = var.databricks_sku

  public_network_access_enabled         = var.databricks_public_access
  network_security_group_rules_required = "NoAzureDatabricksRules"
  no_public_ip                          = var.databricks_no_public_ip

  virtual_network_id                = module.databricks_vnet.vnet_id
  public_subnet_name                = module.databricks_vnet.public_subnet_name
  private_subnet_name               = module.databricks_vnet.private_subnet_name
  public_subnet_nsg_association_id  = module.databricks_vnet.public_nsg_id
  private_subnet_nsg_association_id = module.databricks_vnet.private_nsg_id

  tags = {
    environment = var.environment
    managed_by  = "terraform"
    purpose     = "databricks-workspace"
  }

  depends_on = [module.databricks_vnet]
}

# Unity Catalog Module
module "unity_catalog" {
  source = "./modules/unity_catalog"

  access_connector_name = var.unity_catalog_access_connector_name
  resource_group_name   = module.resource_group.resource_group_name
  location              = var.location
  storage_account_name  = var.unity_catalog_storage_account_name
  container_name        = var.unity_catalog_container_name

  tags = {
    environment = var.environment
    managed_by  = "terraform"
    purpose     = "unity-catalog"
  }
}

# App Service Module for Bot
module "bot_app_service" {
  source = "./modules/app_service"

  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  service_plan_name   = var.service_plan_name
  os_type             = var.app_service_os_type
  sku_name            = var.app_service_sku
  web_app_name        = var.web_app_name
  node_version        = var.node_version

  tags = {
    environment = var.environment
    managed_by  = "terraform"
    purpose     = "bot-backend"
  }

  depends_on = [module.resource_group]
}

# Azure Bot Module
module "azure_bot" {
  source = "./modules/azure_bot"

  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  app_insights_name   = var.app_insights_name
  api_key_name        = var.app_insights_api_key_name
  bot_name            = var.bot_name
  bot_location        = "global"
  bot_sku             = var.bot_sku
  bot_endpoint        = module.bot_app_service.bot_endpoint

  tags = {
    environment = var.environment
    managed_by  = "terraform"
    purpose     = "azure-bot"
  }

  depends_on = [module.resource_group, module.bot_app_service]
}

