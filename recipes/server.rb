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

# TODO : fix me
remote_file "/usr/src/cassandra-#{node['cassandra']['version']}.tar.gz" do
  action :create_if_missing
  source "https://#{node['ele']['buildbot_user']}:#{node['ele']['buildbot_password']}@" \
         "#{node['ele']['buildbot_host']}/distfiles/cassandra-builds/cassandra-#{node['cassandra']['version']}.tar.gz"
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
