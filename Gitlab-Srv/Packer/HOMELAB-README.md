<a href="https://www.packer.io/">
    <img src="../.icon_source/packer.png" alt="Packer logo" title="Packer" align="center" height="100" /> 
</a>


## README To Be Completed
This Build Creates a "Template" and adds it to the vCenter content_library. The Template can then be used by Terraform. Terraform will clone the template and create a VM.

* Done:
    * Debian 11 image build

* To be Done:
    * ubuntu 22.04 image build
    * Centos 8 image build

# Build Command line:

```
packer build -var-file=./Var_Files/<file>.pkrvar.hcl .
```

### Exemple: 

```
packer build -var-file=./Var_Files/ubuntu.pkrvar.hcl .

```

## Contributing

* [DevOps Engineer] = Eric QUERCIA
    * https://github.com/RicoQ
    * https://www.linkedin.com/in/eric-quercia/