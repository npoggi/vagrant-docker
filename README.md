vagrant-docker
==============

Use docker instead of a VM (i.e., virtualbox) in Vagrant as a provider to save system resources (and be more fashinable!)

Use this sample code to build your own boxes.

It features Puppet [Chef is optional] and a sample NginX web Server


##Simple usage:
cd vagrant-docker

**vagrant up**

##Test:
Navigate to: http://localhost:8080/

Builds your own docker image from the Dockerfile

##Advanced usage: (select your image in a ENV var)

####For a vanilla image built using the same docker file:

DOCKER_IMAGE='npoggi/vagrant-docker' vagrant up provision

####For a pre-provisioned image with the puppet config (saves time)

DOCKER_IMAGE='npoggi/vagrant-docker-provisioned' vagrant up

##Notes:
In case you switch images do a vagrant provision instead of just vagrant up

Originally presented at the *Docker meetup in Barcelona*: http://www.meetup.com/docker-barcelona-spain/events/193336922/








