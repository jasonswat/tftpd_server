template "#{node['tftpd_server']['lighttpd_doc_root']}/ubuntu.minimal" do
  source 'ubuntu.minimal.preseed.erb'
  mode '0755'
  owner 'root'
  group 'root'
end

template "#{node['tftpd_server']['lighttpd_doc_root']}/bootstrap.sh" do
  source 'bootstrap.sh.erb'
  mode '0755'
  variables(
    cloudconfig: node['tftpd_server']['coreos']['cloudconfigurl'] 
  )
end
