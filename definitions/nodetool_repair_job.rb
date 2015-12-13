define :nodetool_repair_job, interval: nil, enabled: false do
  cluster_type = params[:name]
  interval = params[:interval]
  fail 'interval must be set!' if interval.nil? # TODO : sane default

  runit_service "job-nodetool-repair-#{cluster_type}" do
    cookbook 'cassandra'
    run_template_name 'job'
    log_template_name 'job'
    owner 'daemon'
    group 'daemon'
    options(
      job_name: "nodetool-repair-#{cluster_type}",
      job_path: "/opt/cassandra/bin/nodetool repair -pr -h localhost -p #{node['cassandra']['jmx_port']}",
      args: "--locking --interval #{interval}"
    )
  end if params[:enabled]
end
