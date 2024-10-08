terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.115"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.4"
    }
  }

  required_version = "< 2"
}

provider "azurerm" {
  features {}
}
