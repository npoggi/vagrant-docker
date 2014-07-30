# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'
#avoids having to $ vagrant provider=docker
ENV['VAGRANT_DEFAULT_PROVIDER'] ||= 'docker'

#print 'Loading the Vagrantfile...\n'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  #sample web server host
  config.vm.define 'web' do |web|
    web.vm.provider 'docker' do |d|

      #use a prebuilt image ie 'npoggi/vagrant-docker:latest'
      if ENV['DOCKER_IMAGE'] then
        print 'Using docker image ' + ENV['DOCKER_IMAGE'] +' (downloads if necessary)\n'
        d.image = ENV['DOCKER_IMAGE']
      else
        #build from the Dockerfile
        print 'Building from the Dockerfile (if necessary)\n'
        d.build_dir = '.'
        d.name = 'vagrant-docker'
      end

      #the docker image must remain running for SSH (See the Dockerfile)
      d.has_ssh = true

      #in case you don't use defaults in Vagrant
      #d.ssh.port = 2222
      #d.ssh.username = 'root'
      #d.ssh.password = 'pass'

      #other options
      #d.remains_running = false
    end

    web.vm.host_name = 'vagrant-web'

    #web document root
    web.vm.synced_folder 'web-root/', '/vagrant/web-root'

    #net ports
    web.vm.network :forwarded_port, host: 8080, guest: 80 #web

    #bash scripts
    config.vm.provision :shell, :path => 'bootstrap.sh'

    #puppet config
    web.vm.provision 'puppet' do |puppet|
      puppet.module_path = 'puppet/modules'
      puppet.manifests_path = 'puppet/manifests'
      puppet.manifest_file = 'init_web.pp'
      #puppet.options = '--verbose --debug'
    end
  end

  #container linking for multiple machines
  # Read http://docs.docker.com/userguide/dockerlinks/#container-linking
  #d.link('vagrant-docker:web')

end