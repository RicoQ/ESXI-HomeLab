
resource "vsphere_virtual_machine" "vm" {
  # Global Info
  name             = var.vm_name
  host_system_id   = data.vsphere_host.host.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datacenter_id    = data.vsphere_datacenter.dc.id
  datastore_id     = data.vsphere_datastore.datastore.id
  
  #wait_for_guest_net_timeout = 2
  #wait_for_guest_ip_timeout  = 2

  # Resource Info
  num_cpus              = var.cpus
  num_cores_per_socket  = var.cores
  memory                = var.ram

  # folder                = vsphere_folder.folder.path # "VM/"
  guest_id              = var.os_guest
  firmware              = var.firmware

  scsi_type             = var.disk_if_type # "lsilogic"
  scsi_bus_sharing      = var.disk_if_bus # "physicalSharing"

  # Network Info
  network_interface {
    network_id = data.vsphere_network.network.id
  }

  # Disk Info
  disk {
    label             = "${var.vm_name}-disk0"
    thin_provisioned  = false
    eagerly_scrub     = true
    size              = local.disk_size
    unit_number       = 0
    attach            =  true
    disk_sharing      = local.disk_if_bus
    datastore_id      = data.vsphere_datastore.datastore.id
    path              = "${var.vm_path}/${var.vm_name}-${var.disk_lable}.vmdk"
  }

  connection {
      host            = self.default_ip_address
      type            = var.communicator
      user            = local.ssh_user
      password        = local.ssh_pwd
  }

  # OVF Info
  ovf_deploy {
    allow_unverified_ssl_cert = true
    #local_ovf_path            = "${local.local_ovf_path}/${data.vsphere_content_library.Packer_library.name}"
    remote_ovf_url            = data.vsphere_content_library.Packer_library.id
    disk_provisioning         = data.vsphere_ovf_vm_template.ovfLocal.disk_provisioning
    ovf_network_map           = data.vsphere_ovf_vm_template.ovfLocal.ovf_network_map
  }

  # Clone Template From Content Library
  clone {
    template_uuid = "${data.vsphere_content_library_item.template.id}"
    #customize {
    #  # Ref: https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/virtual_machine#virtual-machine-customizations
    #
    #  # Global Settings
    #  dns_server_list = local.vm_dns_list
    #  ipv4_gateway = local.vm_ipv4_gateway
    #
    #  # Network Settings
    #  network_interface {
    #    ipv4_address = local.vm_ipv4
    #    ipv4_netmask = local.vm_ipv4_mask
    #  }
    # 
    #  # Linux Setting
    #  linux_options {
    #    host_name = local.vm_name
    #    domain    = local.domain
    #  }
    #}
  }

  # ADD the host to the Ansible inventory
  provisioner "local-exec" {
    command = "echo \"${var.vm_name} ansible_host=${self.default_ip_address} ansible_user=${var.ssh_user} ansible_password=${var.ssh_pwd}\" >> ${path.root}/../Ansible/inventory"
  }

  provisioner "remote-exec" {
    inline = ["echo ${local.ssh_root_pwd} | sudo su - root -c \"ifconfig $1 | grep \"inet\" | awk -F: '{print $1}' | awk '{print $2}'\""]
    
    connection {
      host        = self.default_ip_address
      type        = var.communicator
      user        = local.ssh_user
      password    = local.ssh_pwd
    }
  }

  # provisioner "local-exec" {
  #   command = "ansible-playbook -u ${local.ssh_user} -i \"${self.default_ip_address},\" -e \"ssh_user=${local.ssh_user} -e \"SERVICE=${local.service}\" -e \"VERSION=${local.service_ver}\" -e \"ansible_password=${local.ssh_pwd}\" -e \"ansible_sudo_pass=${local.ssh_pwd}\" ../ansible/main.yml"
  # }

  depends_on = [ 
    # module.build_packer_image.terraform_data,
    vsphere_virtual_disk.virtual_disk
  ]
}

resource "ansible_playbook" "playbook" {
  playbook   = "${path.root}/../Ansible/main.yml"
  name       = vsphere_virtual_machine.vm.default_ip_address
  replayable = true

  ignore_playbook_failure = false

  extra_vars = {
    ssh_user          = "${local.ssh_user}"
    SERVICE           = "${local.service}" 
    VERSION           = "${local.service_ver}"
    ansible_user      = "${local.ssh_user}"
    ansible_password  = "${local.ssh_pwd}"
    ansible_sudo_pass = "${local.ssh_root_pwd}"
    # ansible_check_mode = true
  }
  
  depends_on = [ 
    # module.build_packer_image.terraform_data,
    vsphere_virtual_machine.vm
  ]
}

resource "vsphere_virtual_disk" "virtual_disk" {
  size               = local.disk_size
  type               = local.disk_type
  vmdk_path          = "${local.vm_path}${local.service}/${local.vm_name}-${var.distribution}-disk0.vmdk"
  create_directories = true
  datacenter         = data.vsphere_datacenter.dc.name
  datastore          = data.vsphere_datastore.datastore.name
}