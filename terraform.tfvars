resource_group_name  = "rg-testing"
location             = "East US"
environment          = "development"
storage_account_name = "tfstatetesting12345"
container_name       = "tfstate"

# Databricks Configuration
databricks_workspace_name    = "dbw-testing-workspace"
databricks_vnet_name         = "vnet-databricks"
vnet_address_space           = ["10.0.0.0/16"]
public_subnet_prefix         = ["10.0.1.0/24"]
private_subnet_prefix        = ["10.0.2.0/24"]
databricks_sku               = "premium"
databricks_public_access     = false
databricks_no_public_ip      = true

# Unity Catalog Configuration
unity_catalog_access_connector_name = "dbw-access-connector"
unity_catalog_storage_account_name  = "unitycatalogstore123"
unity_catalog_container_name        = "unity-catalog"
