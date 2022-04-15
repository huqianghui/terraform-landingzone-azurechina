terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.97.0"
    }
  }

  backend "azurerm" {
      resource_group_name  = "tfstate"
      storage_account_name = "tfstate2022"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
      subscription_id      = "cc2fb595-1a97-4bc0-b33e-8955f43d1b05"
      environment          = "china"

  }

}
provider "azurerm" {
features {}

environment = "china"
}

provider "azurerm" {
  alias           = "connectivity"
  subscription_id = var.connectivitySubscriptionId
  features {}
  environment = "china"
}

provider "azurerm" {
  alias           = "management"
  subscription_id = var.managementSubscriptionId
  features {}
  environment = "china"
}