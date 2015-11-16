# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.require_version '>= 1.5.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = 'cassandra.local'

  config.vm.box = 'chef/ubuntu-14.04'

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :private_network, type: 'dhcp'

  config.vm.boot_timeout = 120

  config.vm.provider :virtualbox do |vb|
    vb.memory = 1024
  end

  config.omnibus.chef_version = 'latest'

  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      'cassandra' => {
        'bacon' => false
      }
    }

    chef.run_list = [
      'recipe[cassandra::default]'
    ]
  end
end
