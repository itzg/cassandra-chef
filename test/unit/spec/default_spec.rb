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

  # it 'unpacks cql tarball' do
  #   expect(chef_run).to create_untar_archive('cql')
  # end

  it 'downloads cql tarball' do
    expect(chef_run).to create_remote_file_if_missing('/usr/src/cql-1.0.5.tar.gz')
  end

  it 'creates cql environment script file with attributes' do
    expect(chef_run).to create_file('/etc/profile.d/cql_env.sh')
  end

  it 'creates replication factor script file with attributes' do
    expect(chef_run).to create_file('/etc/profile.d/cql_replication_factor.sh')
  end
end
