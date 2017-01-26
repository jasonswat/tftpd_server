# encoding: utf-8
#
# Cookbook Name:: tftpd_server 
# Attribute:: default
#
# pkgs needed for pxeboot
default['tftpd_server']['pkgs'] = [
  'tftpd-hpa',
  'pxelinux',
  'inetutils-inetd',
  'syslinux-common',
  'syslinux',
  'tcpdump',
  'lighttpd',
  'openssh-server'
  ]
default['tftpd_server']['lighttpd_doc_root'] = '/var/www/html'
default['tftpd_server']['tftp_directory'] = '/tftpboot'
default['tftpd_server']['boot_logo_src'] = 'https://raw.githubusercontent.com/jasonswat/coreos_pxe/master/logo.png'
default['tftpd_server']['coreos']['cloudconfigurl'] = 'http://192.168.10.184/MyWeb/software/cloud-config.yaml'
default['tftpd_server']['coreos']['core_url'] = 'http://stable.release.core-os.net/amd64-usr/current'
default['tftpd_server']['ubuntu']['chef_deb_pkg_url'] = 'https://packages.chef.io/stable/ubuntu/12.04/chefdk_0.14.25-1_amd64.deb'
default['tftpd_server']['ubuntu']['lvm_guided_size'] = '20%'
default['tftpd_server']['ubuntu']['root_password'] = 'r00tme'
default['tftpd_server']['ubuntu']['user_fullname'] = 'Default User'
default['tftpd_server']['ubuntu']['username'] = 'trixter'
default['tftpd_server']['ubuntu']['password'] = 'trixter1'
default['tftpd_server']['ubuntu']['hostname'] = 'trixter'
default['tftpd_server']['ubuntu']['filesystem'] = 'ext4'
default['tftpd_server']['ubuntu']['distro_url'] = 'http://archive.ubuntu.com/ubuntu/dists' 
default['tftpd_server']['dban_url'] = 'http://sourceforge.net/projects/dban/files/dban/dban-2.3.0/dban-2.3.0_i586.iso/download'
default['tftpd_server']['archlinux_url'] = 'http://releng.archlinux.org/pxeboot/ipxe.lkrn'
default['tftpd_server']['ubuntu']['distros'] = {
  trusty: 'cad0f44d6a93be1fc6e78d47df431c05daf2687a4f9621e9b4195d06320e58af',
  xenial: '12af843b596ba433309eb9023ede8b8451ebd5f0e8269217665012afcebdfd26',
  yakkety: '6bd66b947bf704621ebfba05213b14223e9f391ebbcf7fad21cc8fe51dda76c6' }
