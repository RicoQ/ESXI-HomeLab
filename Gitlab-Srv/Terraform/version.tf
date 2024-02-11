terraform {
  required_version = ">= 1.7.0"
  # backend "local" {
  #   path = "./Backend/gitlab.tfstate"
  # }

  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = ">= 2.6.0"
    }
  } 
}

provider "vsphere" {
      user           = local.esxi.user
      password       = local.esxi.pwd
      vsphere_server = local.esxi.name

      # If you have a self-signed cert
      allow_unverified_ssl = true
}