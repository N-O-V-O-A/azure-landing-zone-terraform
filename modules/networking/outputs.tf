output "hub_resource_group_name" {
  description = "Name of the hub resource group"
  value       = azurerm_resource_group.hub.name
}

output "hub_vnet_id" {
  description = "Resource ID of the hub VNet"
  value       = azurerm_virtual_network.hub.id
}

output "hub_vnet_name" {
  description = "Name of the hub VNet"
  value       = azurerm_virtual_network.hub.name
}

output "firewall_subnet_id" {
  description = "Resource ID of AzureFirewallSubnet"
  value       = azurerm_subnet.firewall.id
}

output "bastion_subnet_id" {
  description = "Resource ID of AzureBastionSubnet"
  value       = azurerm_subnet.bastion.id
}

output "spoke_resource_group_name" {
  description = "Name of the spoke resource group"
  value       = azurerm_resource_group.spoke.name
}

output "spoke1_workload_subnet_id" {
  description = "Resource ID of the spoke 1 workload subnet"
  value       = azurerm_subnet.spoke1_workload.id
}

output "spoke2_workload_subnet_id" {
  description = "Resource ID of the spoke 2 workload subnet"
  value       = azurerm_subnet.spoke2_workload.id
}