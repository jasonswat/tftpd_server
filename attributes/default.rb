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
  'lighttpd'
  ]
default['tftpd_server']['lighttpd_doc_root'] = '/var/www/html'
default['tftpd_server']['tftp_directory'] = '/tftpboot'
default['tftpd_server']['boot_logo_src'] = 'https://raw.githubusercontent.com/jasonswat/coreos_pxe/master/logo.png'
default['tftpd_server']['coreos']['cloudconfigurl'] = 'http://192.168.10.184/MyWeb/software/cloud-config.yaml'
default['tftpd_server']['ubuntu']['chef_deb_pkg_url'] = 'https://packages.chef.io/stable/ubuntu/12.04/chefdk_0.14.25-1_amd64.deb'
default['tftpd_server']['ubuntu']['lvm_guided_size'] = '20%'
default['tftpd_server']['ubuntu']['root_password'] = 'r00tme'
default['tftpd_server']['ubuntu']['user_fullname'] = 'Default User'
default['tftpd_server']['ubuntu']['username'] = 'trixter'
default['tftpd_server']['ubuntu']['password'] = 'cowie'
default['tftpd_server']['ubuntu']['hostname'] = 'trixter'
default['tftpd_server']['ubuntu']['filesystem'] = 'ext4'
default['tftpd_server']['ubuntu']['distro_url'] = 'http://archive.ubuntu.com/ubuntu/dists' 
default['tftpd_server']['dban_url'] = 'http://sourceforge.net/projects/dban/files/dban/dban-2.3.0/dban-2.3.0_i586.iso/download'
default['tftpd_server']['ubuntu']['distros'] = {
  trusty: 'cad0f44d6a93be1fc6e78d47df431c05daf2687a4f9621e9b4195d06320e58af',
  xenial: '12af843b596ba433309eb9023ede8b8451ebd5f0e8269217665012afcebdfd26',
  yakkety: 'f2dc0cf772af013357e7027de023236e20d964762b9449b5f1adbd01684b942a' }
