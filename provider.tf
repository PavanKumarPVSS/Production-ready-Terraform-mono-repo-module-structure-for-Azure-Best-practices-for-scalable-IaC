terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  
  # Uncomment after initial deployment of storage account
  # backend "azurerm" {
  #   resource_group_name  = "rg-testing"
  #   storage_account_name = "tfstatetesting12345"
  #   container_name       = "tfstate"
  #   key                  = "terraform.tfstate"
  # }
}

provider "azurerm" {
  features {}
}
