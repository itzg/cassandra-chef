#
# Cookbook Name:: Cassandra
# Recipe:: Server
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
  source 'https://1897ddfb466c9e3b1daa-525efbc04163a45a7d6a38d479995b34.ssl.cf2.rackcdn.com/cassandra-20130603180240.tar.gz'
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
