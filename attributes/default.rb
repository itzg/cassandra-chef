require 'pathname'

default['cassandra']['cql_version']  = '1.0.5'
default['cassandra']['cql_base_url'] = 'http://cassandra-dbapi2.apache-extras.org.codespot.com/files/'
# 'https://storage.googleapis.com/google-code-archive-downloads/v1/apache-extras.org/cassandra-dbapi2/'
default['cassandra']['version'] = '20130603180240'
default['cassandra']['min_mem'] = '128M' # TODO: use ruby numeric type
default['cassandra']['max_mem'] = '256M' # TODO: use ruby numeric type
default['cassandra']['concurrent_writes'] = 32
default['cassandra']['commitlog_total_space_in_mb'] = 4096
default['cassandra']['sliced_buffer_size_in_kb'] = 64
default['cassandra']['compaction_throughput_mb_per_sec'] = 16
default['cassandra']['hinted_handoff_enabled'] = true
default['cassandra']['inter_dc_tcp_nodelay'] = true
default['cassandra']['rpc_port'] = 9160
default['cassandra']['storage_port'] = 7000
default['cassandra']['jmx_port'] = 9080
default['cassandra']['mx4j_port'] = 9081
default['cassandra']['rpc_server_type'] = 'hsha'

default['cassandra']['var_dir'] = Pathname.new '/var/lib/cassandra'
default['cassandra']['data_dir'] = node['cassandra']['var_dir'] + 'data'
default['cassandra']['commitlog_dir'] = node['cassandra']['var_dir'] + 'commitlog'
default['cassandra']['saved_caches_dir'] = node['cassandra']['var_dir'] + 'saved_caches'

default['cassandra']['seed_servers'] = ['127.0.0.1']

# attributes for nodetool repair job
default['cassandra']['nodetool_repair_enabled'] = false
default['cassandra']['nodetool_repair_interval'] = 216_000_000
