terraform {
    required_version = ">=1.5"

    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~>4.0"
        }
    }

    backend "azurerm" {
        resource_group_name = "rg-tfstate-dev-westus"
        storage_account_name = "sttfstatedev29116"
        container_name = "tfstate"
        key = "landongzone.dev.tfstate"
        use_azuread_auth = true
    }
}

provider "azurerm" {
    features{}
}