# encoding: utf-8
# Cookbook Name: tftpd_server
# Recipe: tftpd_server 

# setup some variables
dban_dir="#{node['tftpd_server']['tftp_directory']}/DBAN/2.0/i386"
http_server = "http://#{node['network']['interfaces']['enp0s8']['routes'][0]['src']}"

# dump of node objects, since I don't have knife
ruby_block "Save node attributes" do
  block do
    if Dir::exist?('/tmp/kitchen')
      IO.write("/tmp/kitchen/chef_node.json", node.to_json)
    end
  end
end

# ubuntu key update
execute 'apt-get-update' do
  command 'apt-get update;apt-key update'
  action :run
end

# install the neccessary packages
node['tftpd_server']['pkgs'].each do |pkg|
  package pkg do
    options '--force-yes'
  end
end

service 'tftpd-hpa' do
  action :start
end

# setup directories
directory node['tftpd_server']['tftp_directory']
directory '/mnt/loop'
directory dban_dir do
  recursive true
end

['pxelinux.cfg', 'ubuntu', 'coreos', 'utilities', 'archlinux'].each do |dir|
  directory "#{node['tftpd_server']['tftp_directory']}/#{dir}"
end

node['tftpd_server']['ubuntu']['distros'].each do |distro, checksum|
  directory "#{node['tftpd_server']['tftp_directory']}/ubuntu/#{distro}"
  ark "#{distro}" do
    path "#{node['tftpd_server']['tftp_directory']}/ubuntu/#{distro}/amd64"
    url "#{node['tftpd_server']['ubuntu']['distro_url']}/#{distro}/main/installer-amd64/current/images/netboot/netboot.tar.gz"
    checksum checksum
    environment(
      TAR_OPTIONS: '--strip-components=3'
    )
    action :dump
    backup false
  end
end

['/usr/lib/syslinux/modules/bios/ldlinux.c32',
 '/usr/lib/syslinux/modules/bios/libutil.c32',
 '/usr/lib/syslinux/modules/bios/vesamenu.c32',
 '/usr/lib/syslinux/modules/bios/menu.c32',
 '/usr/lib/syslinux/modules/bios/libcom32.c32',
 '/usr/lib/PXELINUX/pxelinux.0'].each do |file| 
  ruby_block 'copy syslinux files' do
    block do
      require 'fileutils'
      FileUtils.cp "#{file}",
      node['tftpd_server']['tftp_directory']
    end
  not_if { File.exist?("#{node['tftpd_server']['tftp_directory']}/pxelinux.0") }
  end
end

# tftpd config file setup
template '/etc/default/tftpd-hpa' do
  source 'tftpd-hpa.erb'
  mode '0755'
  owner 'root'
  group 'root'
  variables(
    tftp_directory: node['tftpd_server']['tftp_directory']
  )
  notifies :reload, 'service[tftpd-hpa]', :immediately
end

# pxelinux.cfg/default and pxe.conf setup
['default', 'pxe.conf'].each do | pxelinux_file |
  template "#{node['tftpd_server']['tftp_directory']}/pxelinux.cfg/#{pxelinux_file}" do
    source "#{pxelinux_file}.erb"
    mode '0755'
    notifies :reload, 'service[tftpd-hpa]', :immediately
  end
end

# setup the menu files
['utilities', 'coreos', 'ubuntu', 'archlinux'].each do |menu_name|
  template "#{node['tftpd_server']['tftp_directory']}/#{menu_name}/#{menu_name}.menu" do
    source "#{menu_name}.menu.erb"
    mode '0755'
    variables(
      dban_dir: dban_dir,
      http_server: http_server,
      distros: node['tftpd_server']['ubuntu']['distros'] 
    )
  notifies :reload, 'service[tftpd-hpa]', :immediately
  end
end

# dban setup
remote_file '/tmp/dban.iso' do
  source node['tftpd_server']['dban_url']
  checksum '7613dafc1cfc77054dcf5f7d01682d808bc31faaaacfbf3263f4887580103776'
  mode '0755'
  action :create
  notifies :run, 'bash[setup_dban_menu]', :immediately
end

# add logo file
remote_file '/tftpboot/pxelinux.cfg/logo.png' do
  source 'https://raw.githubusercontent.com/jasonswat/coreos_pxe/master/logo.png'
end

bash 'setup_dban_menu' do
  code <<-EOH
    mount -o loop -t iso9660 /tmp/dban.iso /mnt/loop
    cp /mnt/loop/dban.bzi #{dban_dir}
    umount /mnt/loop
    EOH
    action :run
  not_if { ::File.exists?("#{dban_dir}/dban.bzi") }
end

# coreos binary setup
['coreos_production_pxe_image.cpio.gz', 'coreos_production_pxe.vmlinuz'].each do |coreos_bin|
  remote_file "/tftpboot/coreos/#{coreos_bin}" do
    source "#{node['tftpd_server']['coreos']['core_url']}/#{coreos_bin}"
    mode '0755'
    action :create
  end
end
