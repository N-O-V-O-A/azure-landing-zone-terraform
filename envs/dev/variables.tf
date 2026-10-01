variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "westus"
}

variable "environment" {
  description = "Environment name used in resource naming"
  type        = string
  default     = "dev"
}

variable "workload" {
  description = "Workload identifier used in resource naming"
  type        = string
  default     = "lz"
}

variable "hub_address_space" {
  description = "Address space for the hub VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "spoke1_address_space" {
  description = "Address space for spoke 1 VNet"
  type        = list(string)
  default     = ["10.1.0.0/16"]
}

variable "spoke2_address_space" {
  description = "Address space for spoke 2 VNet"
  type        = list(string)
  default     = ["10.2.0.0/16"]
}