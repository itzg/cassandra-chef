require 'chefspec'
require_relative 'spec_helper'

describe 'cassandra::default' do
  before { stub_resources }

  let(:chef_run) { ChefSpec::SoloRunner.new(step_into: ['archives']).converge(described_recipe) }

  it 'installs package' do
    expect(chef_run).to install_package('python-thrift')
  end

  it 'runs a execute with an explicit action' do
    expect(chef_run).to run_execute('install_cqlsh')
  end

  # untar_archive needs to define a custom matcher to be testable here
  # e.g. https://github.com/sethvargo/chefspec#testing-lwrps

  it 'downloads cql tarball' do
    expect(chef_run).to create_remote_file_if_missing('/usr/src/cql-1.0.5.tar.gz')
  end

  it 'creates cql environment script file with attributes' do
    expect(chef_run).to create_file('/etc/profile.d/cql_env.sh')
  end

  it 'creates replication factor script file with attributes' do
    expect(chef_run).to create_file('/etc/profile.d/cql_replication_factor.sh')
  end

  it 'sets expected default attributes' do
    expect(chef_run.node['cassandra']['concurrent_reads']).to eq(32)
    expect(chef_run.node['cassandra']['rpc_max_threads']).to eq(2048)
    expect(chef_run.node['cassandra']['thrift_max_message_length_in_mb']).to eq(16)
  end
end
