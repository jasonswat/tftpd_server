Prereq, it needs chef to be installed. For the vm, I installed it manaully for the PXE boot version, I added the chef install to the preseed file. Here are the steps to install manually:

```
wget https://packages.chef.io/stable/ubuntu/12.04/chefdk_0.14.25-1_amd64.deb
sudo dpkg -i chefdk_0.14.25-1_amd64.deb
```

Installs and configures a tftpd server. I use this on my home network when I need it. It exposes an insecure vagrant box on your network. 

## Packer

There is a packer template if you want to create a virtualbox image to test with. You need to install packer if you don't already have it. This assumes your on a mac and have homebrew installed:

```
brew install packer
```

To validate the template:

```
packer validate ubuntu.packer
```

To build the vbox image:

```
packer build ubuntu.packer
```

