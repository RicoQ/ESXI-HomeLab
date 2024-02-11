##########################################################################
# For more details on each variables below refer to the descriptions 
# contained in the "variables.pkr.hcl" file
##########################################################################


#############################
# Global Info
#############################

#pkr_root_path   = "</Path_to/Packer/files_.pkr.hcl>"    # This is a Directory. ## Exemple : "~/Lab/Packer"
esxi_ip         = "<Esxi_server_ip> or <esxi_server_hostname>"
vm_path         = "</Path_to/VM_folder/on_ESXI>"        # Exemple : "/VM/Packer"  ## This a Directory, full path translates to : /vmfs/volume/<datastore_name.id>/<vm_path>/
Service         = "<name_of_the_service>"               # Exemple : "Update" 
Service_Ver     = "<version_of_the_service>"            # Exemple : "0.1"
library         = "<name_of_the_content_library>"       # The library must already exist on the vCenter  

#############################
# vCenter Connection Info
#############################

vc_host            = "<vCenter_ip> or <vCenter_hostname>"
vc_user            = "<user_name>@<vCenter_AD>"         # Exemple : packer@vcenter.local
vc_pwd             = "<user_password>"
vc_datacenter      = "<datacenter_name>"
#vc_cluster        = "<cluster_name>                    # If there are no clusters, use <esxi_server_ip> or <esxi_hostname>"
vc_datastore       = "<datastore_name>"

#############################
# Image Info
#############################

# You can use either "image_url" or "vc_local_path" but not both.
vc_local_path   = "[<datastor_name>] Path/to/iso_file/" # exemple : "[datastore1] Images/ISO/"  
#image_url       = "<iso_url>"                           # Exemple : "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.6.0-amd64-netinst.iso"
image_checksum  = "<iso_encryption_:_iso_checksum>"     # Exemple : "SHA256:e482910626b30f9a7de9b0cc142c3d4a079fbfa96110083be1d0b473671ce08d"
iso_name        = "<iso_file_name>.iso"                 # Exemple : "debian-11.6.0-amd64-netinst.iso" 
Dist_Name       = "<iso_distribution_name>"             # Exemple : "Debian"  ## This is also used in the <vc_local_path> but should not be included in the above variable
Dist_Ver        = "<iso_distribution_version>"          # Exemple : "11.6" 

#############################
# VM Info
#############################

# Global
vm_name         = "<VM_name>"                           # Exemple : "Debian-Base"
os_type         = "<os_type>                            # Exemple: "debian11_64Guest" 
## See: https://developer.vmware.com/apis/358/vsphere/doc/vim.vm.GuestOsDescriptor.GuestOsIdentifier.html for a full list of os_types.

# Core & RAM
cpus            = "<number_of_vCPUs>"                   # Default is "1"
cores           = "<number_of_cpus_per_socket>"         # Default is "1" (preferably; The same amount as the number of CPUs)
ram             = "<Amount_or_ram>"                     # Default is "512" (= 512Mo)

# Disk
disk_size       = "<disk_size>"                         # Exemple : "20000" (=20Go) ## Default is "16000" (=16Go)
disk_controller = "<disck_controler>"                   # Exemple : ["lsilogic-sas"] ## Default is ["scsi"]

# Network 
net_card        = "<esxi_network_card>"                 # Default is : "vmxnet3"
networks        = "<esxi_network_name>"                 # Default is : "VM Network"  ## Network must already exist
domain_name     = "<Domain_name>                        # Exemple: "exemple.com" # This will create the hostname "<vm_name>.<Domain_name>" ## Default is "home" (i.e = The Livebox network (from orange ISP))

# Extra
firmware        = "<vm_prefered_firmware>"              # Exemple : "bios"
video_ram       = "<video_ram>"                         # Exemple : "131072" (=128Mo) ## Default "4096" (=4Mo)

#############################
# SSH Info
#############################

ssh_comm        = "<communicator>"                      # Default is : "ssh"
ssh_user        = "<user_name>                          # Default is : "packer"   ## must be same as in the preseed.cfg file
ssh_pwd         = "<user_password>"                     # Default is : "packer"   ## must be same as in the preseed.cfg file
ssh_root_pwd    = "<root_password>"                     # Default is : "insecure" ## must be same as in the preseed.cfg file
ssh_time        = "<time_before_ssh_time_out>"          # Default is : "45m"

#############################
# Preseed Info
#############################

#http_dir        = <http_directory>                      # Exemple ./http/Debian/preseed.cfg  ## This is within the "<pkr_root_path>"

# Only use the following if you have an ftp to store the preseed file 
# I was having trouble with the built-in <http_dir>, this is my workaround  
ftp_usr         = "<ftp_user>" 
ftp_pwd         = "<ftp_user_password>" 
ftp_ip          = "<ftp_ip>" 
preseed_file        = "<path_to_preseed_file>"  