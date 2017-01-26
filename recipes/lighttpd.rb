# removed because trusty needs a different file
#node['tftpd_server']['ubuntu']['distros'].each_pair do |distro, checksum_|
['xenial', 'yakkety'].each do |distro|
  template "#{node['tftpd_server']['lighttpd_doc_root']}/#{distro}.ubuntu.minimal" do
    source 'ubuntu.minimal.preseed.erb'
    mode '0755'
    owner 'root'
    group 'root'
    variables(
      distro: distro
    )
    notifies :restart, 'service[lighttpd]', :immediately
  end
end

template "#{node['tftpd_server']['lighttpd_doc_root']}/bootstrap.sh" do
  source 'bootstrap.sh.erb'
  mode '0755'
  variables(
    cloudconfig: node['tftpd_server']['coreos']['cloudconfigurl'] 
  )
  notifies :restart, 'service[lighttpd]', :immediately
end

service 'lighttpd' do
  action :start
end
