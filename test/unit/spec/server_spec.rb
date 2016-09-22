require 'chefspec'
require_relative 'spec_helper'

describe 'cassandra::server' do
  before { stub_resources }

  let(:chef_run) { ChefSpec::SoloRunner.new(step_into: ['archives']).converge(described_recipe) }

  it 'includes the `java` recipe' do
    expect(chef_run).to include_recipe('java')
  end

  it 'installs numactl package' do
    expect(chef_run).to install_package('numactl')
  end

  # it 'unpacks cassandra tarball' do
  #   expect(chef_run).to create_untar_archive('cassandra')
  # end

  it 'downloads cassandra tarball' do
    expect(chef_run).to create_remote_file('/usr/src/cassandra-20160921235957.tar.gz')
  end

  it 'creates properties file' do
    expect(chef_run).to create_template('/opt/ele-conf/cassandra-log4j-server.properties')
  end

  it 'creates commitlog directory with attributes' do
    expect(chef_run).to create_directory('/opt/cassandra-commitlog')
  end

  it 'creates cassandra directory with attributes' do
    expect(chef_run).to create_directory('/var/lib/cassandra')
  end

  it 'creates cassandra symlink' do
    expect(chef_run).to create_link('/opt/cassandra')
  end

  it 'creates commitlog symlink' do
    expect(chef_run).to create_link('/var/lib/cassandra/commitlog')
  end
end
