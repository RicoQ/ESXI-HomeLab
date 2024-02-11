###############
## ESXi Info ##
###############

## Only of the variables: "esxi_host_name" or "esxi_host_ip" is required. 
## If both are supplied then only "esxi_host_ip" is taken into account
esxi_host_name    = "value" # required
esxi_host_ip      = "value" # required
esxi_username     = "value" # required
esxi_password     = "value" # required
esxi_datacenter   = "value" # default = "ha-datacenter"

##################
## vCenter Info ##
##################

## Only of the variables: "vcenter_host_name" or "vcenter_host_ip" is required. 
## If both are supplied then only "vcenter_host_ip" is taken into account
vcenter_host_name = "value" # required
vcenter_host_ip   = "value" # required
vcenter_username  = "value" # required
vcenter_password  = "value" # required

####################
## Resource Infos ##
####################

datacenter        = "value" # required
# "cluster" is only required if multiple cluster
cluster           = "value" # When esxi is standalone either "esxi_host_ip" or "esxi_host_name" is used
datastore         = "value" # required
resource_pool     = "value" # required
network           = "value" # default = "VM Network"

###################
## Global Info ##
###################

tf_root_path      = "value" # default = "./"
library_ds        = "value" # required

###################
## VM Image Info ##
###################

ovf_name          = "value" # required
vm_path           = "value" # default = "/VM/"
firmware          = "value" # default = "bios"
distribution      = "value" # default = "Debian"
dist_ver          = "value" # default = "11.7"
ovf_file_name     = "value" # default = "Packer-build-{{ var.distribution }}-{{ var.dist_ver}}-Setup-1.0.ovf"

#############
## VM Info ##
#############

vm_name           = "value" # required
os_guest          = "value" # default = "other3xLinux64Guest"
cpus              = "value" # default = 4
cores             = "value" # default = 1
ram               = "value" # default = 4096

##################
## VM Disk Info ##
##################

disk_lable        = "value" # default = "disk0"
disk_type         = "value" # default = "eagerZeroedThick"
disk_size         = "value" # default = 16
disk_adapt_type   = "value" # default = "scsi"
disk_if_type      = "value" # default = "lsilogic-sas"
disk_if_bus       = "value" # default = "sharingNone"

#####################
## VM Network Info ##
#####################

vm_network        = "value" # default "VM Network"
vm_domain         = "value" # default "home"
## The following ipv4 variables are marked as required (for later updates).
## Theses variables are not being used.
## Feel free to leave as is but they are required.
vm_ipv4           = "value" # required 
vm_ipv4_mask      = "value" # default = 24
vm_dns_list       = "value" # required --> list --> Exemple: ["1.1.1.1", "8.8.8.8"]
vm_ipv4_gateway   = "value" # required

#################
## VM SSH Info ##
#################

communicator      = "value" # default = "ssh"
ssh_user          = "value" # required
ssh_pwd           = "value" # required
ssh_root_pwd      = "value" # required
ssh_time          = "value" # default = "45m"
shutdown          = "value" # default = "sudo /sbin/init 6"

##################
## Ansible Info ##
##################

service           = "value" # required
service_ver       = "value" # required
