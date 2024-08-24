variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "location" {
  type        = string
  description = "Location of the resources"
}

variable "subnet1" {
  description = "Configuration for subnet1"
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "subnet2" {
  description = "Configuration for subnet2"
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "subnet3" {
  description = "Configuration for subnet3"
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "address_space" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}

variable "nsg_name" {
  type        = string
  description = "Name of the network security group"
}

variable "nsg_name2" {
  type        = string
  description = "Name of the network security group"
}

variable "nsg_name3" {
  type        = string
  description = "Name of the network security group"
}


variable "account_tier" {
  type = string
}

variable "account_replication_type" {
  type = string
}

variable "account_kind" {
  default = "StorageV2"
}

variable "storage_account_name" {
  type = string
}

variable "private_dns_zone_name" {
  type = string
}

variable "privateendpoint_name" {
  type = string
}

variable "private_dns_zone_group_name" {
  type = string
}

variable "private_dns_zone_blob_name" {
  type = string
}
variable "privateendpointblob_name" {
  type = string
}


variable "storage_connection_name" {
  description = "Name of the private connection to the storage account"
  type        = string
}

variable "private_connection_resource_id" {
  description = "Resource ID for the private connection"
  type        = string
}

variable "is_manual_connection" {
  description = "Flag indicating if the connection is manual"
  type        = bool
}

variable "subresource_names" {
  description = "Names of the subresources"
  type        = list(string)
}

variable "KVprivate_dns_zone_name" {
  description = "Name of the private DNS zone"
}

variable "key_vault_name" {
  description = "Name of the Azure Key Vault"
}

variable "tenant_id" {
  description = "ID of the Azure Active Directory tenant"
}

variable "KVprivate_endpoint_name" {
  description = "Name of the Azure Private Endpoint"
}

variable "KVprivate_service_connection_name" {
  description = "Name of the private service connection to the Azure Key Vault"
}
variable "Databricks_Name" {
  type = string
}

variable "managed_resource_group_name" {
  type = string
}

variable "databricks_private_dns_zone_name" {
  type = string
}

variable "adbprivateendpoint" {
  type = string
}

variable "private_service_connection_adbname" {
  type = string
}

variable "private_dns_zone_group_adbname" {
  type = string
}
