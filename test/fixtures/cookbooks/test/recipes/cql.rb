#
# Cookbook Name:: test
# Recipe:: cql
#
# License:: Apache License, Version 2.0
#

include_recipe 'cassandra::cql'

nodetool_repair_job 'cass' do
  interval node.ele.cass.nodetool_repair_interval
  enabled node.ele.cass.nodetool_repair_enabled
end
