resource "azurerm_virtual_network" "default" {
  name                = "${var.projectname}-vnet"
  location            = var.region
  resource_group_name = var.rg_name
  address_space       = [var.cidr]
}

resource "azurerm_subnet" "default" {
  name                 = "${var.projectname}-subnet"
  virtual_network_name = azurerm_virtual_network.default.name
  resource_group_name  = var.rg_name
  address_prefixes     = [cidrsubnet(var.cidr, 1, 0)]
}

resource "azurerm_route_table" "default" {
  name                = "${var.projectname}-rtb"
  location            = var.region
  resource_group_name = var.rg_name

  route {
    name                   = "rfc1918-1"
    address_prefix         = "172.16.0.0/12"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.loadbalancer_ip
  }
  route {
    name                   = "rfc1918-2"
    address_prefix         = "10.0.0.0/8"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.loadbalancer_ip
  }
  route {
    name                   = "rfc1918-3"
    address_prefix         = "192.168.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.loadbalancer_ip
  }
}

resource "azurerm_subnet_route_table_association" "default" {
  subnet_id      = azurerm_subnet.default.id
  route_table_id = azurerm_route_table.default.id
}

resource "azurerm_virtual_network_peering" "hub-to-spoke1" {
  name                      = "hub-to-${var.projectname}"
  resource_group_name       = var.rg_name
  virtual_network_name      = var.hub_vnet_name
  remote_virtual_network_id = azurerm_virtual_network.default.id
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "spoke1-to-hub" {
  name                      = "${var.projectname}-to-hub"
  resource_group_name       = var.rg_name
  virtual_network_name      = azurerm_virtual_network.default.name
  remote_virtual_network_id = var.hub_vnet_id
  allow_forwarded_traffic   = true
  depends_on                = [azurerm_virtual_network_peering.hub-to-spoke1]
}
