require 'chefspec'
require_relative 'spec_helper'

describe 'cassandra::default' do
  before { stub_resources }

  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'installs package' do
    expect(chef_run).to install_package('python-thrift')
  end
end
