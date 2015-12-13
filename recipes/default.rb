#
# Cookbook Name:: Cassandra
# Recipe:: default
#
# Copyright (C) 2015 Rackspace
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
  not_if { node['roles'].include?('dev') }
  owner 'root'
  group 'root'
  mode 00755
  content %(CQLSHARGS="127.0.0.10 9170"\n\nexport CQLSHARGS)
end
