###############
## ESXi Info ##
###############
variable "esxi_host_name" {
  description = "Value of the ip/url for the ESXi server"
  type        = string
  default     = ""
}
variable "esxi_host_ip" {
  description = "Value of the ip (only) for the ESXi server"
  type        = string
  default     = ""
}
variable "esxi_username" {
  description = "Value of the ip/url for the ESXi server"
  type        = string
}
variable "esxi_password" {
  description = "Value of the ip (only) for the ESXi server"
  type        = string
  sensitive = true
}

##################
## vCenter Info ##
##################
variable "vcenter_host_name" {
  description = "Value of the ip/url for the vCenter server"
  type        = string
  default     = ""
}
variable "vcenter_host_ip" {
  description = "Value of the ip (only) for the vCenter server"
  type        = string
  default     = ""
}
variable "vcenter_username" {
  description = "Value of the ip/url for the vCenter server"
  type        = string
}
variable "vcenter_password" {
  description = "Value of the ip (only) for the vCenter server"
  type        = string
  sensitive = true
}

####################
## Resource Infos ##
####################
variable "datacenter" {
  description = "Value of the datacenter name"
  type        = string
}
variable "cluster" {
  description = "Value of the cluster name. Used only with vCenter. If ESXi is standalone with no cluster use <esxi_host>"
  type        = string
  default     = ""
}
variable "datastore" {
  description = "Value of the datastore name"
  type        = string
}
variable "resource_pool" {
  description = "Value of the resource pool name"
  type        = string
}
variable "network" {
  description = "Value of the resource pool name"
  type        = string
  default     = "VM Network"
}

###################
## Global Info ##
###################
variable "tf_root_path" {
  description = "Value of ovf file name contained in the content_libary"
  type        = string
  default     = "./"
}
variable "library_ds" {
  description = "Name of the content_libary datastore"
  type        = string
}

###################
## VM Image Info ##
###################
variable "ovf_name" {
  description = "Value of ovf file name contained in the content_libary"
  type        = string
}
variable "vm_path" {
  description = "Directory where the vm is to be created. (is relative to the datastore)"
  type        = string
  default     = "/VM/"
}
variable "firmware" {
  description = "Firmware used at boot (bios or efi)"
  type        = string
  default     = "bios"
}

#############
## VM Info ##
#############
variable "vm_name" {
  description = "Name of the VM"
  type        = string
}
variable "os_guest" {
  description = "ID of the OS on the VM "
  type        = string
}
variable "cpus" {
  description = "Amount of vCPUs assigned to the VM"
  type        = number
  default     = 4
}
variable "cores" {
  description = "Amount of cores per sockets (usualy the same amount of CPUs)"
  type        = number
  default     = 1
}
variable "ram" {
  description = "Amount of memory assigned to the VM in MB"
  type        = number
  default     = 4024
}

##################
## VM Disk Info ##
##################
variable "disk_lable" {
  description = "Lable for the disk"
  type        = string
  default     = "disk0"
}
variable "disk_type" {
  description = "Disk type ('thin', 'eagerZeroedThick', and 'lazy') "
  type        = string
  default     = "eagerZeroedThick"
}
variable "disk_size" {
  description = "size of of the disk (in GB) "
  type        = number
  default     = 16
}
variable "disk_adapt_type" {
  description = "Type of disk interface (scsi, lsilogic, pvscsi)"
  type        = string
  default     = "scsi"
}
variable "disk_if_type" {
  description = "Type of disk interface (lsilogic-sas, lsilogic, pvscsi)"
  type        = string
  default     = "lsilogic-sas"
}
variable "disk_if_bus" {
  description = "Bus type for the disk interface (noSharing, virtualSharing, physicalSharing)"
  type        = string
  default     = "virtualSharing"
}

#####################
## VM Network Info ##
#####################
variable "vm_network" {
  description = "Name of the network"
  type        = string
  default     = "VM Network"
}
variable "vm_domain" {
  description = "Domain Name"
  type        = string
}
variable "vm_ipv4" {
  description = "IP 'v4' assigned to the vm"
  type        = string
}
variable "vm_ipv4_mask" {
  description = "IPv4 mask"
  type        = number
}
variable "vm_dns_list" {
  description = "list of dns servers"
  type        = list
}
variable "vm_gateway" {
  description = "ip for the network's gateway"
  type        = string
}

#################
## VM SSH Info ##
#################
variable "communicator" {
  description = "communicator used to connect to the vm "
  type        = string
  default     = "ssh"
}
variable "ssh_user" {
  description = "User_Name used to connect to the VM via SSH "
  type        = string
}
variable "ssh_pwd" {
  description = "User_Password used to connect to the VM via SSH"
  type        = string
  sensitive = true
}
variable "ssh_root_pwd" {
  description = "root_Password used to connect to the VM via SSH"
  type        = string
  sensitive = true
}

##################
## Ansible Info ##
##################
variable "service" {
  description = "The name of the service you want to install with Ansible. Exemple: Gitlab "
  type        = string
  default     = "Null"
}
variable "service_ver" {
  description = "The exact version of the service. (Exemple: 15.5.0-ee.0)"
  type        = string
  default     = "Null"
}
