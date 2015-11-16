package 'python-thrift'

remote_file "/usr/src/cql-#{node['cassandra']['cql_version']}.tar.gz" do
  action :create_if_missing
  source "#{node['cassandra']['cql_base_url']}/cql-#{node['cassandra']['cql_version']}.tar.gz"
  mode 00644
end

untar_archive 'cql' do
  path "/usr/src/cql-#{node['cassandra']['cql_version']}.tar.gz"
  container_path '/usr/src'
  creates "/usr/src/cql-#{node['cassandra']['cql_version']}/setup.py"
end

execute 'install_cqlsh' do
  creates "/usr/local/lib/python2.7/dist-packages/cql-#{node['cassandra']['cql_version']}.egg-info"
  command 'python setup.py install -f'
  cwd "/usr/src/cql-#{node['cassandra']['cql_version']}"
end

file '/etc/profile.d/cql_replication_factor.sh' do
  owner 'root'
  group 'root'
  mode 00755
  content 'export REPLICATION_FACTOR=5'
  action :create
end

file '/etc/profile.d/cql_env.sh' do
  not_if { node.roles.include?('dev') }
  owner 'root'
  group 'root'
  mode 00755
  content %(CQLSHARGS="127.0.0.10 9170"\n\nexport CQLSHARGS)
end
