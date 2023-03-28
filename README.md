# terraform-azure-spoke

### Description
Deploys a spoke VNET, attaches it to a hub and assigns RFC1918 routes


### Usage Example
```
module "vnet" {
  source        = "git::https://github.com/fkhademi/terraform-azure-spoke.git"

  projectname     = "frey"
  region          = "West Europe"
  rg_name         = "my_rg"
  cidr            = "10.10.0.0/24"
  loadbalancer_ip = "192.168.1.20"
  hub_vnet_name   = "hub_vnet"
  hub_vnet_id     = "17dcf287-c4a0-47ea-ab49-fb68c121321"

}
```

### Variables
The following variables are required:

key | value
:--- | :---
projectname | Azure resources name prefix
region | Azure region to deploy resources
rg_name | VPC ID to deploy resources
cidr | CIDR for the VNET
loadbalancer_ip | Load Balancer frontend for the NVAs
hub_vnet_name | Hub VNET name
hub_vnet_id | Hub VNET ID

### Outputs
This module will return the following outputs:

key | description
:---|:---
subnet | The Azure Subnet and all of its attributes
vnet | The Azure VNET and all of its attributes