##################################################################################
# General Ref: 
#    https://www.packer.io/plugins/builders/vmware/iso
#    https://developer.hashicorp.com/packer/plugins/builders/vsphere/vsphere-iso
#    https://github.com/hashicorp/packer-plugin-vsphere/blob/main/builder/vsphere/examples/ubuntu/ubuntu-16.04.pkr.hcl
#
# Shutdown Command Ref: 
#    https://github.com/hashicorp/packer/issues/4813 
#    https://developer.hashicorp.com/packer/docs/provisioners/shell
#
# Guest OS Type Ref:
#    https://developer.vmware.com/apis/358/vsphere/doc/vim.vm.GuestOsDescriptor.GuestOsIdentifier.html
#
# Boot commands Ref:
#    https://www.debian.org/releases/jessie/amd64/ch05s03.html.en 
#    https://github.com/tylert/packer-build/tree/master/source 
#    Sequence to enter the automated setup (requires a preseed.cfg file)
#
# Build Block Ref:
#    https://developer.hashicorp.com/packer/docs/templates/hcl_templates/contextual-variables
#    https://developer.hashicorp.com/packer/docs/templates/hcl_templates/blocks/build
#
# Shell Provisioner Ref: 
#    https://developer.hashicorp.com/packer/docs/provisioners/shell
#
# Packer Debug ref:
#    https://developer.hashicorp.com/packer/docs/debugging
#
##################################################################################

source "vsphere-iso" "Packer-Build" {
    # vCenter Connection Info
    vcenter_server      = var.vc_host
    username            = var.vc_user
    password            = var.vc_pwd
        
    # Extra Info
    datacenter          = var.vc_center
    datastore           = var.vc_store
    cluster             = var.esxi_host
    resource_pool       = var.vc_pool
    insecure_connection = true
    destroy             = true

    # Template Info
    notes               = "User INFO:  root:${var.ssh_root_pwd} / ${var.ssh_user}:${var.ssh_pwd} / Distribution:${var.dist_name}-${var.dist_ver}"
    convert_to_template = true
    content_library_destination {
      library           = var.library
      destroy           = false
      ovf               = true
    }

    # Image Source
    iso_checksum        = var.image_checksum
    iso_paths           = ["[${var.vc_store}] ${var.vc_local_path}/${var.dist_name}/${var.iso_name}"]
    folder              = "Packer-Build/${var.dist_name}-${var.dist_ver}-${var.service}-${var.service_ver}"
    
    # SSH Connection Info
    communicator         = "ssh"
    ssh_timeout          = "45m"
    ssh_username         = var.ssh_user
    ssh_password         = var.ssh_pwd

    ## VM Configuration
    host                = var.esxi_host
    vm_name             = "${var.vm_name}-${var.dist_name}-${var.dist_ver}-${var.service}-${var.service_ver}"
    firmware            = "bios"
    guest_os_type       = var.os_type
    
    # VM build Conf
    CPUs                = 2
    cpu_cores           = 1
    RAM                 = 1024
    video_ram           = 4096
    
    # VM Disk conf
    disk_controller_type = ["scsi"]
    storage {
      disk_size         = 16000
      disk_thin_provisioned = false
      disk_eagerly_scrub  = true
      disk_controller_index = 0
    }   
    
    # VM Network Conf
    network_adapters {
      network           = var.networks
      network_card      = var.net_card
    }

    # VM Shutdown Command
    # shutdown_command    = "echo ${var.ssh_root_pwd} | su - root -c \"systemctl poweroff\""

    # Boot commands
    boot_wait           = "5s"
    #http_directory      = "${var.http_dir}/${var.Dist_name}/${var.preseed_file}
    
    boot_command        = [   # This is for a Debian 11.7 build 
      "<wait3s><esc><wait>", "/install.amd/vmlinuz ", "auto=true ", "language=en ",
      "country=FR ", "locale=fr_FR.UTF-8 ", "keymap=fr ", "interface=auto ", "vga=788 ",
      "url=ftp://${var.ftp_usr}:${var.ftp_pwd}@${var.ftp_ip}/${var.preseed_file} ",
      #"url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.preseed_file} ",
      "hostname=${var.vm_name} ", "domain=${var.domain_name} ",
       "initrd=/install.amd/initrd.gz ", "noprompt quiet --<enter>"
    ]

    #boot_command        = [   # This is for a Ubuntu 22.04 build 
    #  "<wait3s><esc><wait>", "/install.amd/vmlinuz ", "auto=true ", "language=en ",
    #  "country=FR ", "locale=fr_FR.UTF-8 ", "keymap=fr ", "interface=auto ", "vga=788 ",
    #  "url=ftp://${var.ftp_usr}:${var.ftp_pwd}@${var.ftp_ip}/${var.ftp_file} ",
    #  #"preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.preseed_file} ",
    #  "hostname=${var.vm_name} ", "domain=${var.domain_name} ",
    #   "initrd=/install.amd/initrd.gz ", "noprompt quiet --<enter>"
    #]

    #boot_command        = [   # This is for a centos 8 build 
    #  "<wait3s><esc><wait>", "/install.amd/vmlinuz ", "auto=true ", "language=en ",
    #  "country=FR ", "locale=fr_FR.UTF-8 ", "keymap=fr ", "interface=auto ", "vga=788 ",
    #  "url=ftp://${var.ftp_usr}:${var.ftp_pwd}@${var.ftp_ip}/${var.ftp_file} ",
    #  #"ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.preseed_file} ",
    #  "hostname=${var.vm_name} ", "domain=${var.domain_name} ",
    #   "initrd=/install.amd/initrd.gz ", "noprompt quiet --<enter>"
    #]
}

build {
  name    = "Packer-Build"
  sources = ["sources.vsphere-iso.Packer-Build"]

  ## The following Local-Shell provisioner is for debug purposes only
  # provisioner "shell-local" {
  #  inline = [   # Ref:  https://developer.hashicorp.com/packer/docs/templates/hcl_templates/contextual-variables
  #    "echo \"######### DEBUG INFO ##########\" ",
  #    "echo  ",
  #    "echo \"var.ssh_pwd is  : ${var.ssh_pwd}\" ",
  #    "echo \"var.ssh_user is : ${var.ssh_user}\" ",
  #    "echo  ",
  #    "echo \"Host is : ${build.Host}\" ",
  #    "echo \"Port is : ${build.Port}\" ",
  #    "echo \"User is : ${build.User}\" ",
  #    "echo \"Pwd is  : ${build.Password}\" ",
  #    "echo  ",
  #    "echo \"######### DEBUG INFO ##########\" "
  #  ]
  # }

  # Testing ssh Connection with a simple command
  provisioner "shell" {
    # inline = [ "echo ${var.ssh_root_pwd} | su - root -c \"apt-get install -y sudo open-vm-tools perl\"" ]
    # inline = [ "echo \"${var.ssh_root_pwd} | su - root -c echo \"Setup Complete\" \" " ]
    inline = [ "cat ~/.bashrc" ]
  }

  # provisioner "ansible" {
  #   user             = "${build.User}"
  #   use_proxy        = false
  #   playbook_file    = "${var.pkr_root_path}/../Ansible/main.yml"
  #   roles_path       = "${var.pkr_root_path}/../Ansible/roles/"
  #   ansible_env_vars = [ 
  #     "ANSIBLE_HOST_KEY_CHECKING=False", 
  #     "ANSIBLE_CONFIG=${var.pkr_root_path}/../Ansible/ansible.cfg",
  #     #"ansible_ssh_host=${build.Host}",
  #   ]
  #   extra_arguments  = [
  #     #"-vvvv",
  #     "-e", "ansible_host=${build.Host}",
  #     "-e", "ansible_sudo_pass=sdfghjkl",
  #     "-e", "ansible_password=sdfghjkl",
  #     "-e", "ssh_user=gitadmin",  
  #     "-e", "SERVICE=${var.service}",
  #     "-e", "VERSION=${var.service_ver}",
  #   ]
  # }
}