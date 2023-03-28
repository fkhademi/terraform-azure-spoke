variable "projectname" {
  description = "Name to prefix all of the resources"
}

variable "rg_name" {
  description = "Azure Resource Group Name"
}

variable "region" {
  description = "Azure Region"
}

variable "cidr" {
  description = "VNET CIDR ranges"
}

variable "loadbalancer_ip" {
  description = "Loadbalancer IP that is frontending the NVAs"
}

variable "hub_vnet_name" {
  description = "Name of the VNET Hub"
}

variable "hub_vnet_id" {
  description = "ID of the VNET Hub"
}
