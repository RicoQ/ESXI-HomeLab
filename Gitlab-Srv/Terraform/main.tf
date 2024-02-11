module "deploy_vm" {
  source = "./module/deploy_vm"

  ## ESXi connection
  esxi_host_name = local.esxi.name
  esxi_username  = local.esxi.user
  esxi_password  = local.esxi.pwd

  ## vCenter connection
  vcenter_host_name = local.vcenter.name
  vcenter_username  = local.vcenter.user
  vcenter_password  = local.vcenter.pwd
  
  # Resources
  datacenter      = local.datacenter
  cluster         = local.esxi.name
  datastore       = local.datastore
  resource_pool   = local.resource_pool
  network         = local.network
    
  # Global
  library_ds      = var.library_ds
  tf_root_path    = local.tf_root_path

  # Service
  service         = local.service
  service_ver     = local.service_ver
    
  # ovf 
  ovf_name        = local.ovf_name
  vm_path         = local.vm_path
  firmware        = local.firmware

  # vm
  vm_name         = local.vm_name
  os_guest        = local.os_guest
  cpus            = local.cpus
  cores           = local.cores
  ram             = local.ram
  disk_lable      = local.disk_lable
  disk_type       = local.disk_type
  disk_size       = local.disk_size
  disk_adapt_type = local.disk_adapt_type
  disk_if_type    = local.disk_if_type
  disk_if_bus     = local.disk_if_bus
    
  # network
  vm_network      = local.vm_network
  vm_domain       = local.vm_domain
  vm_ipv4         = local.vm_ipv4
  vm_ipv4_mask    = local.vm_ipv4_mask
  vm_dns_list     = local.vm_dns_list
  vm_ipv4_gateway = local.vm_gateway
  
  # ssh
  communicator    = local.communicator
  ssh_user        = local.ssh_user
  ssh_pwd         = local.ssh_pwd
  ssh_root_pwd    = local.ssh_root_pwd
}

output "playbook_stderr" {
  value = module.deploy_vm.playbook_stderr
}

output "playbook_stdout" {
    value = module.deploy_vm.playbook_stdout
}