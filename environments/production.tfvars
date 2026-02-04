resource_group_name  = "rg-production"
location             = "East US"
environment          = "production"
storage_account_name = "tfstateprod98765"
container_name       = "tfstate"

# Databricks Configuration
databricks_workspace_name = "dbw-prod-workspace"
databricks_vnet_name      = "vnet-databricks-prod"
vnet_address_space        = ["10.2.0.0/16"]
public_subnet_prefix      = ["10.2.1.0/24"]
private_subnet_prefix     = ["10.2.2.0/24"]
databricks_sku            = "premium"
databricks_public_access  = false
databricks_no_public_ip   = true

# Unity Catalog Configuration
unity_catalog_access_connector_name = "dbw-prod-access-connector"
unity_catalog_storage_account_name  = "unitycatalogprod789"
unity_catalog_container_name        = "unity-catalog"

# App Service Configuration
service_plan_name    = "bot-service-plan-prod"
app_service_os_type  = "Linux"
app_service_sku      = "S1"
web_app_name         = "prod-bot-webapp"
node_version         = "18-lts"

# Azure Bot Configuration
bot_name                  = "prod-azure-bot"
bot_sku                   = "S1"
app_insights_name         = "bot-app-insights-prod"
app_insights_api_key_name = "bot-api-key-prod"
