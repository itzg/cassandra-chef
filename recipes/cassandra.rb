include_recipe 'java'

package 'numactl' do
  action :install
end

directory '/opt/cassandra-commitlog' do
  owner 'daemon'
  group 'daemon'
  mode 00755
  recursive true
end

directory '/var/lib/cassandra' do
  owner 'daemon'
  group 'daemon'
  mode 00755
  recursive true
end

remote_file "/usr/src/cassandra-#{node['cassandra']['version']}.tar.gz" do
  action :create_if_missing
  source "https://#{node[:ele][:buildbot_user]}:#{node[:ele][:buildbot_password]}@#{node[:ele][:buildbot_host]}/distfiles/cassandra-builds/cassandra-#{node[:cassandra][:version]}.tar.gz"
  mode 00644
end

untar_archive 'cassandra' do
  path "/usr/src/cassandra-#{node['cassandra']['version']}.tar.gz"
  container_path '/opt'
  creates "/opt/cassandra-#{node['cassandra']['version']}/lib"
end

template '/opt/ele-conf/cassandra-log4j-server.properties' do
  mode 00644
  source 'log4j-server.properties.erb'
end

link '/opt/cassandra' do
  to "/opt/cassandra-#{node['cassandra']['version']}"
end

link '/var/lib/cassandra/commitlog' do
  to '/opt/cassandra-commitlog'
end
