### Global Info
variable "pkr_root_path" {
  description = "The directory of your Packer tamplate. The default is ./"
  type    = string
  default = "./"
}
variable "esxi_host" {
  description = "The <host_ip> for the ESXi machine."
  type    = string
}
variable "service" {
  description = "The name of the service you want to install with Ansible. Exemple: Gitlab "
  type        = string
  default     = "Setup"
  }
variable "service_ver" {
  description = "The exact version of the service. (Exemple: 15.5.0-ee.0)"
  type        = string
  default     = "1.0"
  }
variable "library" {
  description = "The Library name on the vCenter where the template will be saved to. Must already exist on the vCenter."
  type        = string
}

### vCenter Connection Info
variable "vc_host" {
  description = "The <host_name>, <host_ip> or <host_url> to the vcenter machine."
  type    = string
}
variable "vc_user" {
  description = "The SSH username used to access the vcenter machine."
  type    = string
}
variable "vc_pwd" {
  description = "The SSH user password used to access the vcenter machine."
  type    = string
}
variable "vc_center" {
  description = "The name of the datacenter where the VM will be stored on the vcenter machine."
  type    = string
}
variable "vc_cluster" {
 #only needed with vCenter with multiple hosts. when dealing with standalone esxi host use the esxi host ip/hostname as the cluster name.  
 description = "The name of the cluster where the VM will be stored on the ESXi machine."
 type    = string
 default = ""
}
variable "vc_pool" {
  description = "Resource pool into which the virtual machine template should be placed."
  type        = string
}
variable "vc_store" {
  description = "The name of the datastore where the VM will be stored on the ESXi machine."
  type    = string
}

### Image Info 
#variable "image_url" {
#  description = " A URL to the ISO containing the installation image or virtual hard drive (VHD or VHDX) file to clone."
#  type    = string
#} 
variable "image_checksum" {
  description = "The checksum for the ISO file or virtual hard drive file. The type of the checksum is specified within the checksum field as a prefix, ex: 'md5:{$checksum}'. The type of the checksum can also be omitted and Packer will try to infer it based on string length. Valid values are 'none', '{$checksum}', 'md5:{$checksum}', 'sha1:{$checksum}', 'sha256:{$checksum}', 'sha512:{$checksum}' or 'file:{$path}'."
  type    = string
}
variable "vc_local_path" {
  description = "The path where the image is stored on the vCenter."
  type    = string
}
variable "iso_name" {
  description = "The name of the iso. (must include the .<extention_name> (ie: image.iso)"
  type    = string
}
variable "dist_name" {
  description = "The name of the distribution used for the image. This is used in the naming of the VM"
  type    = string
  default = ""
}
variable "dist_ver" {
  description = "The version of the distribution used for the image. This is used in the naming of the VM"
  type    = string
  default = ""
}

### VM Info
# Global
variable "vm_name" {
  description = "The Name assigned to the VM"
  type    = string
}
variable "os_type" {
  description = "The guest OS type being installed. This will be set in the VMware VMX. By default this is other."
  type    = string
}

# Network
variable "net_card" {
  description = "Set VM network card type. Example "
}
variable "networks" {
  description = "The custom name of the network. Sets the vmx value 'ethernet0.networkName'"
  type    = string
}
variable "domain_name" {
  description = "Domain Name for the VM. "
  type    = string
  default = "home"
}

# Extra
variable "firmware" {
  description = "Set the Firmware for virtual machine. Supported values: bios, efi or efi-secure."
  type    = string
  default = "bios"
}
variable "video_ram" {
  description = "The amount of RAM for the video_ram. Value is in KB"
  type    = number
  default = 4096
}

### SSH Info
variable "ssh_comm" {
  description = "Packer currently supports three kinds of communicators (none / ssh / winrm )" 
  type    = string
  default = "ssh"
}
variable "ssh_key" {
  description = "Path to a PEM encoded private key file to use to authenticate with SSH. The ~ can be used" 
  type        = string
  default     = "~/.ssh/id_rsa"
}
variable "ssh_pub" {
  description = "Path to user certificate used to authenticate with SSH. The ~ can be used" 
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
variable "ssh_user" {
  description = "The username to connect to SSH with. Required if using SSH" 
  type    = string
}
variable "ssh_pwd" {
  description = "A plaintext password to use to authenticate with SSH"
  type    = string
}
variable "ssh_root_pwd" {
  description = "A plaintext password to use to for the user root"
  type    = string
}
variable "ssh_time" {
  description = "(duration string | ex: '1h5m2s') - The time to wait for SSH to become available."
  type    = string
  default = "45m"
}

### Preseed Info
#variable "http_dir" {
#  description = "Path to a directory to serve using an HTTP server. The files in this directory will be available over HTTP that will be requestable from the virtual machine. This is useful for hosting kickstart files and so on. By default this is an empty string, which means no HTTP server will be started. The address and port of the HTTP server will be available as variables in boot_command."
#  type = string 
#}

# Only use the following if you have an ftp to store the preseed file 
# I was having trouble with the built-in <http_directory>, this is my workaround  
variable "ftp_usr" {
  description = "The user name used to connect to ftp "
  type = string 
  }
variable "ftp_pwd" {
  description = "The user password used to connect to ftp "
  type = string 
}
variable "ftp_ip" {
  description = "The ip for the ftp "
  type = string 
}
variable "preseed_file" {
  description = "The path for the preseed file on the ftp. Note: the file should be placed in the <ftp_usr> home directory and the path starts after /home/$USER/ "
  type = string 
  default = "preseed.cfg"
  #The default full path is translated to /home/<ftp_usr>/<Dist_Name>/preseed.cfg (make sure you have the same on your FTP)
}