terraform {
  required_providers {

    random = {
      source = "hashicorp/random"
      version = "~> 3.6.0"
    }

    vsphere = {
      source = "hashicorp/vsphere"
      version = "~> 2.6.1"
    }

    ansible = {
      version = "~> 1.1.0"
      source  = "ansible/ansible"
    }

  }
}

provider "vsphere" {
      user           = local.vcenter.user
      password       = local.vcenter.pwd
      vsphere_server = local.vcenter.name

      # If you have a self-signed cert
      allow_unverified_ssl = true
}