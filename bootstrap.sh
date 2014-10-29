#!/bin/bash

#passwordless login to localhost (in case necessary)
if [ ! -f "/home/vagrant/.ssh/id_rsa" ] ; then
  sudo -u vagrant ssh-keygen -t rsa -P '' -f /home/vagrant/.ssh/id_rsa
  sudo -u vagrant cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
  echo -e "Host *\n\t   StrictHostKeyChecking no\nUserKnownHostsFile=/dev/null\nLogLevel=quiet" > /home/vagrant/.ssh/config
  chown -R vagrant: /home/vagrant/.ssh #just in case
fi

#install puppet if not present
if ! which puppet > /dev/null; then
  wget http://apt.puppetlabs.com/puppetlabs-release-stable.deb -O /tmp/puppetlabs-release-stable.deb && \
    dpkg -i /tmp/puppetlabs-release-stable.deb && \
    apt-get update && \
    apt-get install puppet puppet-common hiera facter virt-what lsb-release -y --force-yes
fi

#install puppet modules in case necessary
[ -d /etc/puppet/modules ] || mkdir -p /etc/puppet/modules
for module in "" ; do
  (puppet module list | grep "$module") || puppet module install "$module"
done

