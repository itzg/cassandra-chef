require 'pathname'

default['cassandra']['version'] = '20130603180240'
default['cassandra']['cql_version']  = '1.0.5'
default['cassandra']['cql_base_url'] = 'http://cassandra-dbapi2.apache-extras.org.codespot.com/files/'
# 'https://storage.googleapis.com/google-code-archive-downloads/v1/apache-extras.org/cassandra-dbapi2/'
default['cassandra']['cassandra_syncer_version'] = '1024d7144d574f87062546f3b6cffedc7158c1ca'

default['cassandra']['cluster_name'] = 'data'

default['cassandra']['max_mem'] = '256M'
default['cassandra']['min_mem'] = '128M'

default['cassandra']['commitlog_total_space_in_mb'] = 4096
default['cassandra']['compaction_throughput_mb_per_sec'] = 16
default['cassandra']['concurrent_reads'] = 32
default['cassandra']['concurrent_writes'] = 32
default['cassandra']['hinted_handoff_enabled'] = true
default['cassandra']['rpc_server_type'] = 'hsha'
default['cassandra']['rpc_max_threads'] = 2048
default['cassandra']['sliced_buffer_size_in_kb'] = 64
default['cassandra']['thrift_max_message_length_in_mb'] = 16

# Ports
default['cassandra']['inter_dc_tcp_nodelay'] = true
default['cassandra']['rpc_port'] = 9160 # + 5
default['cassandra']['storage_port'] = 7000 # + 5
default['cassandra']['jmx_port'] = 9080 # + 5
default['cassandra']['mx4j_port'] = 9081 # + 5

# Directories
default['cassandra']['var_dir'] = Pathname.new '/var/lib/cassandra'
default['cassandra']['data_dir'] = node['cassandra']['var_dir'] + 'data'
default['cassandra']['commitlog_dir'] = node['cassandra']['var_dir'] + 'commitlog'
default['cassandra']['saved_caches_dir'] = node['cassandra']['var_dir'] + 'saved_caches'

# Peers
default['cassandra']['listen_ip'] = '127.0.0.1'
default['cassandra']['seed_servers'] = [node['cassandra']['listen_ip']]

# Nodetool repair job
default['cassandra']['nodetool_repair_enabled'] = false
default['cassandra']['nodetool_repair_interval'] = 216_000_000

default['cassandra']['initial_token'] = 0
default['cassandra']['service_down'] = false
