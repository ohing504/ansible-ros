#!/usr/bin/env ruby
# vim: ft=ruby expandtab shiftwidth=2 tabstop=2

require 'yaml'

ENV['LC_ALL'] = 'en_US.UTF-8'

Vagrant.require_version '>= 1.5'

Vagrant.configure('2') do |config|

  _conf = YAML.load(
    File.open(
      File.join(File.dirname(__FILE__), 'env_vars/vagrant.yml'),
      File::RDONLY
    ).read
  )

  # Machine Settings
  # https://www.vagrantup.com/docs/vagrantfile/machine_settings.html
  config.vm.box = ENV['box'] || _conf['box'] || 'ubuntu/xenial64'
  config.vm.box_check_update = true
  config.vm.hostname = _conf['hostname']
  config.vm.network 'private_network', ip: _conf['ip']

  # VirtualBox configuration
  # https://www.vagrantup.com/docs/virtualbox/configuration.html
  config.vm.provider 'virtualbox' do |vb|
    vb.name = _conf['hostname']
    vb.linked_clone = _conf['linked_clone'] || false

    vb.memory = _conf['memory'].to_i
    vb.cpus = _conf['cpus'].to_i

    if 1 < _conf['cpus'].to_i
      vb.customize ['modifyvm', :id, '--ioapic', 'on']
    end
    vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    vb.customize ['setextradata', :id, 'VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled', 0]
  end

  # SSH Settings
  # https://www.vagrantup.com/docs/vagrantfile/ssh_settings.html
  config.ssh.forward_agent = true

  # Plugin: Hostsupdater
  # https://github.com/cogitatio/vagrant-hostsupdater
  if Vagrant.has_plugin?('vagrant-hostsupdater')
    config.hostsupdater.remove_on_suspend = true
  end

  # Plugin: vbguest
  # https://github.com/dotless-de/vagrant-vbguest
  if Vagrant.has_plugin?('vagrant-vbguest')
    config.vbguest.auto_update = false
  end

  # Provisioning Settings
  # https://www.vagrantup.com/docs/provisioning/
  config.vm.provision 'ansible_local' do |ansible|
    ansible.compatibility_mode = '2.0'
    ansible.playbook = 'vagrant.yml'
    ansible.verbose = 'vv'
  end

end
