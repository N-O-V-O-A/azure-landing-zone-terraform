variable "location" {
  description = "Azure region for all networking resources"
  type        = string
}

variable "suffix" {
  description = "Naming suffix, e.g. lz-dev-westus"
  type        = string
}

variable "tags" {
  description = "Tags applied to all taggable resources"
  type        = map(string)
}

variable "hub_address_space" {
  description = "Address space for the hub VNet"
  type        = list(string)
}

variable "firewall_subnet_prefix" {
  description = "Address prefix for AzureFirewallSubnet"
  type        = list(string)
}

variable "bastion_subnet_prefix" {
  description = "Address prefix for AzureBastionSubnet"
  type        = list(string)
}

variable "spoke1_address_space" {
  description = "Address space for spoke 1 VNet"
  type        = list(string)
}

variable "spoke1_workload_prefix" {
  description = "Address prefix for spoke 1 workload subnet"
  type        = list(string)
}

variable "spoke2_address_space" {
  description = "Address space for spoke 2 VNet"
  type        = list(string)
}

variable "spoke2_workload_prefix" {
  description = "Address prefix for spoke 2 workload subnet"
  type        = list(string)
}