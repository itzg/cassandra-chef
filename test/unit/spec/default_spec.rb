require 'chefspec'
require_relative 'spec_helper'

describe 'cassandra::default' do
  before { stub_resources }

  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'includes the `cql` recipe' do
    expect(chef_run).to include_recipe('cassandra::cql')
  end
end
