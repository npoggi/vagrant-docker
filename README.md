vagrant-docker
==============

Use docker instead of a VM (i.e., virtualbox) in Vagrant as a provider to save system resources
(and be more *fashionable!*)

Use this sample code to build your own boxes.

**Read** latest presentation about this project: https://github.com/npoggi/vagrant-docker/blob/master/presentation/NPoggi_Vagrant-Docker.pdf?raw=true

Fork, and send your pull requests!

The image is currently based on Ubuntu:12.04
It features Puppet [Chef is optional] and a sample NginX web Server


### Simple usage:
##### Builds your own docker image from the Dockerfile
cd vagrant-docker

sudo **vagrant up**

### Test:
Navigate to: http://localhost:8080/


### Advanced usage:
##### Select your image in a ENV var

##### For a vanilla image built using the same docker file:

DOCKER_IMAGE='npoggi/vagrant-docker' sudo vagrant up --provision

##### For a pre-provisioned image with the puppet config (saves time)

DOCKER_IMAGE='npoggi/vagrant-docker-provisioned' sudo vagrant up --provision

### Notes:
In case you switch images do a **vagrant provision** (or vagrant up --provision) instead of just vagrant up.
As *docker* by default stops services if not specified in the Dockerfile.
Puppet as the provisioner with make sure they are UP!

Originally presented at the *Docker meetup in Barcelona*: http://www.meetup.com/docker-barcelona-spain/events/193336922/








