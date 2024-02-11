locals {
    ## Esxi Connection
    esxi = { 
        name = var.esxi_host_name
        user = var.esxi_username
        pwd  = var.esxi_password
        dc   = var.esxi_datacenter
    }

    ## vCenter Connection
    vcenter = {
        name = coalesce(var.vcenter_host_ip, var.vcenter_host_name, "esxi.home")
        user = var.vcenter_username
        pwd  = var.vcenter_password
    }

    ## Resources
    datacenter      = var.datacenter
    cluster         = var.cluster
    datastore       = var.datastore
    resource_pool   = var.resource_pool
    network         = var.network
    
    ## Global
    library_ds      = var.library_ds
    tf_root_path    = var.tf_root_path

    ## Service
    service         = var.service
    service_ver     = var.service_ver
    
    ## ovf 
    # ovf_name        = var.ovf_name
    ovf_name        = "ff564e048-ebef-41e7-9234-72eb55364d83/Packer-Gitlab-16.8-Debian-11.7_7190179d-6023-4940-8c23-99fcb1f67265.ovf"
    vm_path         = var.vm_path
    firmware        = var.firmware

    ## vm
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
    disk_if_bus     = var.disk_if_type
    
    ## network
    vm_network      = var.vm_network
    vm_domain       = var.vm_domain
    vm_ipv4         = var.vm_ipv4
    vm_ipv4_mask    = var.vm_ipv4_mask
    vm_dns_list     = var.vm_dns_list
    vm_gateway      = var.vm_ipv4_gateway
  
    ## ssh
    communicator    = var.communicator
    ssh_user        = var.ssh_user
    ssh_pwd         = var.ssh_pwd
    ssh_root_pwd    = var.ssh_root_pwd 
    ssh_time        = var.ssh_time
    shutdown        = var.shutdown
}