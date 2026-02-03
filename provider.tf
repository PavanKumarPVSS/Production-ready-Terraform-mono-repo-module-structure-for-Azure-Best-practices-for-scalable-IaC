terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  
  # Backend configuration - values provided via pipeline variables
  backend "azurerm" {
  }
}

provider "azurerm" {
  features {}
}
