output "vnet" {
  description = "Azure VNET and all of its attributes"
  value       = azurerm_virtual_network.default
}

output "subnet" {
  description = "Azure Subnet and all of its attributes"
  value       = azurerm_subnet.default
}

