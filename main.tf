module "ResourceGroup" {
  source              = "https://github.com/PavanKumarPVSS/Terraform-single-repo-module-structure/tree/6b35d43bab30e88d903e12d40298a87be11b5691/ResourceGroup"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}
module "network" {
  depends_on          = [module.ResourceGroup]
  source              = "./network"
  resource_group_name = var.resource_group_name
  vnet_name           = var.vnet_name
  location            = var.location
  address_space       = var.address_space
  subnets1            = var.subnet1
  subnets2            = var.subnet2
  subnets3            = var.subnet3
  tags                = var.tags
  nsg_name            = var.nsg_name
  nsg_name2           = var.nsg_name2
  nsg_name3           = var.nsg_name3
}

module "storage_account" {
  source                         = "./storage_account"
  depends_on                     = [module.ResourceGroup, module.network]
  resource_group_name            = var.resource_group_name
  storage_account_name           = var.storage_account_name
  location                       = var.location
  tags                           = var.tags
  account_tier                   = var.account_tier
  account_replication_type       = var.account_replication_type
  account_kind                   = var.account_kind
  subnet3_id                     = module.network.subnet3_id
  private_dns_zone_name          = var.private_dns_zone_name
  privateendpoint_name           = var.privateendpoint_name
  private_dns_zone_group_name    = var.private_dns_zone_group_name
  private_dns_zone_blob_name     = var.private_dns_zone_blob_name
  privateendpointblob_name       = var.privateendpointblob_name
  private_connection_resource_id = var.private_connection_resource_id
  subresource_names              = var.subresource_names
  is_manual_connection           = var.is_manual_connection
  storage_connection_name        = var.storage_connection_name

}

module "KeyVault" {
  source                            = "./key_vault"
  depends_on                        = [module.network, module.ResourceGroup, module.storage_account]
  resource_group_name               = var.resource_group_name
  key_vault_name                    = var.key_vault_name
  location                          = var.location
  tenant_id                         = var.tenant_id
  KVprivate_dns_zone_name           = var.KVprivate_dns_zone_name
  KVprivate_endpoint_name           = var.KVprivate_endpoint_name
  KVprivate_service_connection_name = var.KVprivate_service_connection_name
  tags                              = var.tags
  subnet3_id                        = module.network.subnet3_id
}

module "databricks" {
  source                             = "./databricks"
  depends_on                         = [module.ResourceGroup, module.network, module.storage_account, module.KeyVault]
  resource_group_name                = var.resource_group_name
  location                           = var.location
  virtual_network_id                 = module.network.vnet_id
  subnet1_name                       = module.network.subnet1_name
  subnet2_name                       = module.network.subnet2_name
  nsg_sub1_id                        = module.network.nsg_sub1_id
  nsg_sub2_id                        = module.network.nsg_sub2_id
  subnet3_id                         = module.network.subnet3_id
  tags                               = var.tags
  Databricks_Name                    = var.Databricks_Name
  managed_resource_group_name        = var.managed_resource_group_name
  databricks_private_dns_zone_name   = var.databricks_private_dns_zone_name
  adbprivateendpoint                 = var.adbprivateendpoint
  private_service_connection_adbname = var.private_service_connection_adbname
  private_dns_zone_group_adbname     = var.private_dns_zone_group_adbname
}

