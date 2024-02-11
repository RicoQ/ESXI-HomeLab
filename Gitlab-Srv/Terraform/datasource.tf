data "vsphere_datacenter" "dc" {
  name = local.datacenter
}

data "vsphere_host" "host" {
  name = local.esxi.name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name          = local.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

# data "vsphere_cluster" "cluster" {
#   name          = local.esxi.name
#   datacenter_id = data.vsphere_datacenter.dc.id
# }

data "vsphere_resource_pool" "pool" {
  name          = local.resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = local.network
  datacenter_id = data.vsphere_datacenter.dc.id
}
