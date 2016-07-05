define :cassandra_cluster do
  include_recipe 'cassandra::cassandra'

  cluster_type = params[:name]

  # TODO : move to non ele-specific path
  template "/opt/ele-conf/#{cluster_type}.yaml" do
    mode 00444
    source 'cassandra.yaml.erb'
    cookbook 'cassandra'
    variables(
      cluster_type: cluster_type,
      cass_seed_servers: node['cassandra']['seed_servers'],
      cluster_name: node['cassandra']['cluster_name'],
      listen_ip: node['cassandra']['listen_ip'],
      initial_token: node['cassandra']['initial_token']
    )
  end

  runit_service cluster_type do
    owner 'daemon'
    group 'daemon'
    cookbook 'cassandra'
    run_template_name 'cassandra'
    log_template_name 'cassandra'
    finish_script_template_name 'cassandra'
    finish true
    restart_on_update false
    start_down node['cassandra']['service_down']
    options(
      min_memory: node['cassandra']['min_mem'],
      max_memory: node['cassandra']['max_mem'],
      listen_ip: node['cassandra']['listen_ip'],
      servicename: cluster_type
    )
  end
end
