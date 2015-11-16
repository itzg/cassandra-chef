define :cassandra_cluster do
  include_recipe 'cassandra::cassandra'

  cluster_type = params[:name]

  template "/opt/ele-conf/#{cluster_type}.yaml" do
    mode 00444
    source 'cassandra.yaml.erb'
    cookbook 'cassandra'
    variables(
      cluster_type: cluster_type,
      cass_seed_servers: node['ele'][cluster_type]['seed_servers'],
      cluster_name: node['ele'][cluster_type]['cluster_name'],
      listen_ip: node['ele'][cluster_type]['listen_ip'],
      initial_token: node['ele'][cluster_type]['initial_token']
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
    start_down node['ele'][cluster_type]['service_down']
    options(
      min_memory: node['ele'][cluster_type]['min_mem'],
      max_memory: node['ele'][cluster_type]['max_mem'],
      listen_ip: node['ele'][cluster_type]['listen_ip'],
      servicename: cluster_type
    )
  end
end
