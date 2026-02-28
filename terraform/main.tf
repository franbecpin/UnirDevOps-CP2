terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Grupo de recursos donde irá TODO
resource "azurerm_resource_group" "rg" {
  name     = "rg-casopractico2"
  location = "West Europe" 
}