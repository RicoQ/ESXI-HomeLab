<a href="https://terraform.io">
    <img src="../.icon_source/terraform.png" alt="Terraform logo" title="Terraform" align="center" height="100" />
</a>


# Terraform Provider for vSphere
https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs


## Requirements

* [Terraform 0.12+][terraform-install]

* [VMware vSphere][vmware-vsphere-documenation] 6.5 or later.
    
>**NOTE**: 
- The terraform provider for vSphere requires API write access and is therefore **not supported** for use with a free VMware vSphere Hypervisor license.

- A vCenter server is needed as some features for Terraform and Packer are not supported on a standalone ESXi. (i.e: Template cloning and ovf manipulations) I was having a lot of erros so I desided to try the vcenter providers instead and it made it a lot easier no more errors.

- I need to start working with Vault (ansible and terraform). at the moment all my Passwords and sensible data are in plain text in a '.tfvar' and '.pkrvar.hcl', I've added this files to the .gitignore to keep them secured to my pc only... but I really need to get familiar and use the vaults. So those tools are soon to come.

## Using the Provider

```shell
terraform apply --var-file=./Var_Files/<Var_File_name>.tfvars -auto-approve
```

## Upgrading the Provider

The provider does not upgrade automatically. After each new release, you can run the following command to upgrade the provider:

```shell
terraform init -upgrade
```

## Contributing
* [DevOps Engineer] = Eric QUERCIA
    * https://github.com/RicoQ
    * https://www.linkedin.com/in/eric-quercia/

## License

