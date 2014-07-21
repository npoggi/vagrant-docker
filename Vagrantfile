# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  #config.vm.box = "base"
  config.vm.provider "docker" do |d, o|
    #d.image = "ubuntu:12.04"
    d.build_dir = "."
    d.name = 'vagrant-docker'
    d.has_ssh = true
    #o.ssh.port = 22
    #o.ssh.username = "root"
    #o.ssh.password = "root"    
  end

  config.vm.host_name = "vagrant"

  #web document root
  config.vm.synced_folder "../", "/vagrant/workspace"

  #bash scripts
  config.vm.provision :shell, :path => "bootstrap.sh"

  #puppet config
  config.vm.provision "puppet" do |puppet|
    puppet.module_path = "puppet/modules"
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "init.pp"
    #puppet.options = "--verbose --debug"
  end

  #net ports
  config.vm.network :forwarded_port, host: 8080, guest: 80 #web
end
