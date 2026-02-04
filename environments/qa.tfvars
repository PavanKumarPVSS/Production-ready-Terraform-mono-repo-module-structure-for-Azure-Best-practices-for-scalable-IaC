resource_group_name  = "rg-qa"
location             = "East US"
environment          = "qa"
storage_account_name = "tfstateqa67890"
container_name       = "tfstate"

# Databricks Configuration
databricks_workspace_name = "dbw-qa-workspace"
databricks_vnet_name      = "vnet-databricks-qa"
vnet_address_space        = ["10.1.0.0/16"]
public_subnet_prefix      = ["10.1.1.0/24"]
private_subnet_prefix     = ["10.1.2.0/24"]
databricks_sku            = "premium"
databricks_public_access  = false
databricks_no_public_ip   = true

# Unity Catalog Configuration
unity_catalog_access_connector_name = "dbw-qa-access-connector"
unity_catalog_storage_account_name  = "unitycatalogqa456"
unity_catalog_container_name        = "unity-catalog"

# App Service Configuration
service_plan_name    = "bot-service-plan-qa"
app_service_os_type  = "Linux"
app_service_sku      = "B1"
web_app_name         = "qa-bot-webapp"
node_version         = "18-lts"

# Azure Bot Configuration
bot_name                  = "qa-azure-bot"
bot_sku                   = "S1"
app_insights_name         = "bot-app-insights-qa"
app_insights_api_key_name = "bot-api-key-qa"
