# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
#avoids having to $ vagrant provider=docker
VAGRANT_DEFAULT_PROVIDER = "docker"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  #config.vm.box = "base"
  config.vm.provider "docker" do |d|
    #use a prebuilt image
      #d.image = "npoggi:vagrant-docker"

    #build
      d.build_dir = "."
      d.name = 'vagrant-docker'
      d.has_ssh = true

      #in case you don't use defaults in Vagrant
      #d.ssh.port = 2222
      #d.ssh.username = "root"
      #d.ssh.password = "pass"
  end

  config.vm.host_name = "vagrant"

  #web document root
  config.vm.synced_folder "web-root/", "/vagrant/web-root"

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