# Data source for vCenter Content Library
data "vsphere_content_library" "Packer_library" {
  name = "Packer Library"
}

# Data source for vCenter Content Library Item
data "vsphere_content_library_item" "template" {
  # name       = local.ovf_name
  name       = "Packer-build-Debian-11.7-Setup-1.0.ovf"
  type       = "ovf"
  library_id = data.vsphere_content_library.Packer_library.id
}

# Folder where the vm will be stored
resource "vsphere_folder" "folder" {
  path          = "VM/"
  type          = "vm"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}