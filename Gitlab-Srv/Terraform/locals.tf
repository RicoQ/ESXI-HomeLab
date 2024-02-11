locals {
    # Esxi Connection
    esxi = { 
        name = coalesce(var.esxi_host_ip, var.esxi_host_name, "esxi.home")
        user = var.esxi_username
        pwd  = var.esxi_password
    }

    # vCenter Connection
    vcenter = { 
        name = coalesce(var.vcenter_host_ip, var.vcenter_host_name, "vcenter.home")
        user = var.vcenter_username
        pwd  = var.vcenter_password
    }

    # Resources
    datacenter      = var.datacenter
    cluster         = local.esxi.name
    datastore       = var.datastore
    resource_pool   = var.resource_pool
    network         = var.network
    
    # Global
    library_ds      = var.library_ds
    tf_root_path    = var.tf_root_path

    # Service
    service         = var.service
    service_ver     = var.service_ver
    
    # ovf 
    ovf_name        = var.ovf_name
    vm_path         = var.vm_path
    firmware        = var.firmware

    # vm
    vm_name         = var.vm_name
    os_guest        = var.os_guest
    cpus            = var.cpus
    cores           = var.cores
    ram             = var.ram
    disk_lable      = var.disk_lable
    disk_type       = var.disk_type
    disk_size       = var.disk_size
    disk_adapt_type = var.disk_adapt_type
    disk_if_type    = var.disk_if_type
    disk_if_bus     = var.disk_if_bus
    
    # network
    vm_network      = var.vm_network
    vm_domain       = var.vm_domain
    vm_ipv4         = var.vm_ipv4
    vm_ipv4_mask    = var.vm_ipv4_mask
    vm_dns_list     = var.vm_dns_list
    vm_gateway      = var.vm_gateway
  
    # ssh
    communicator    = var.communicator
    ssh_user        = var.ssh_user
    ssh_pwd         = var.ssh_pwd
    ssh_root_pwd    = var.ssh_root_pwd
}
