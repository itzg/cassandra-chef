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

package 'python-thrift' do
  ignore_failure true
end

package 'libjna-java' do
  ignore_failure true
end

ark 'cql' do
  url "#{node['cassandra']['cql_base_url']}/cql-#{node['cassandra']['cql_version']}.tar.gz"
  version node['cassandra']['cql_version']
  checksum '13406943020da729898d1bf6147b2a01401c5a370b4bb552af5cd7e47b6f94e6'
end

execute 'install_cqlsh' do
  creates "/usr/local/lib/python2.7/dist-packages/cql-#{node['cassandra']['cql_version']}.egg-info"
  command 'python setup.py install -f'
  cwd "/usr/local/cql-#{node['cassandra']['cql_version']}"
end

file '/etc/profile.d/cql_replication_factor.sh' do
  owner 'root'
  group 'root'
  mode 0o0755
  content 'export REPLICATION_FACTOR=5'
  action :create
end

file '/etc/profile.d/cql_env.sh' do
  not_if { node['roles'].include?('dev') }
  owner 'root'
  group 'root'
  mode 0o0755
  content %(CQLSHARGS="127.0.0.10 9170"\n\nexport CQLSHARGS)
end
