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
#   name          = local.esxi_host_name
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

## Local OVF/OVA Source
data "vsphere_ovf_vm_template" "ovfLocal" {
  name              = local.vm_name
  disk_provisioning = local.disk_type
  resource_pool_id  = data.vsphere_resource_pool.pool.id
  datastore_id      = data.vsphere_datastore.datastore.id
  host_system_id    = data.vsphere_host.host.id
  # local_ovf_path    = "/vmfs/volumes/${local.library_ds}/packer/${var.ovf_name}"
  remote_ovf_url    = "https://${local.esxi.user}:${local.esxi.pwd}@${local.esxi.name}/folder/contentlib-${data.vsphere_content_library.Packer_library.id}%2${local.ovf_name}?dcPath=${local.esxi.dc}&dsName=${local.library_ds}"
  allow_unverified_ssl_cert = true
   
  ovf_network_map = {
    "VM Network" : data.vsphere_network.network.id
  }
}

