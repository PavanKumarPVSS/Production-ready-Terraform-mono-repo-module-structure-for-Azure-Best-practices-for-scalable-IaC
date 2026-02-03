resource "azurerm_resource_group" "testing" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = var.environment
    managed_by  = "terraform"
  }
}

resource "azurerm_storage_account" "tfstate" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.testing.name
  location                 = azurerm_resource_group.testing.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  blob_properties {
    versioning_enabled = true
  }

  tags = {
    environment = var.environment
    managed_by  = "terraform"
    purpose     = "tfstate"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

# VNet Module for Databricks
module "databricks_vnet" {
  source = "./modules/vnet"

  vnet_name           = var.databricks_vnet_name
  location            = var.location
  resource_group_name = azurerm_resource_group.testing.name
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
  resource_group_name = azurerm_resource_group.testing.name
  location            = var.location
  sku                 = var.databricks_sku

  public_network_access_enabled         = var.databricks_public_access
  network_security_group_rules_required = "NoAzureDatabricksRules"
  no_public_ip                          = var.databricks_no_public_ip

  virtual_network_id                   = module.databricks_vnet.vnet_id
  public_subnet_name                   = module.databricks_vnet.public_subnet_name
  private_subnet_name                  = module.databricks_vnet.private_subnet_name
  public_subnet_nsg_association_id     = module.databricks_vnet.public_nsg_id
  private_subnet_nsg_association_id    = module.databricks_vnet.private_nsg_id

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
  resource_group_name   = azurerm_resource_group.testing.name
  location              = var.location
  storage_account_name  = var.unity_catalog_storage_account_name
  container_name        = var.unity_catalog_container_name

  tags = {
    environment = var.environment
    managed_by  = "terraform"
    purpose     = "unity-catalog"
  }
}
