locals {
  suffix = "${var.workload}-${var.environment}-${var.location}"

  tags = {
    environment = var.environment
    project     = "azure-landing-zone"
    managed_by  = "terraform"
    owner       = "bryan"
  }
}

module "networking" {
  source = "../../modules/networking"

  location = var.location
  suffix   = local.suffix
  tags     = local.tags

  hub_address_space      = var.hub_address_space
  firewall_subnet_prefix = ["10.0.1.0/26"]
  bastion_subnet_prefix  = ["10.0.2.0/26"]

  spoke1_address_space   = var.spoke1_address_space
  spoke1_workload_prefix = ["10.1.1.0/24"]

  spoke2_address_space   = var.spoke2_address_space
  spoke2_workload_prefix = ["10.2.1.0/24"]
}