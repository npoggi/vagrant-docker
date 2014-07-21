#!/bin/bash

#install puppet modules
[ -d /etc/puppet/modules ] || mkdir -p /etc/puppet/modules
for module in "puppetlabs-apt" "puppetlabs-mysql" ; do
  (puppet module list | grep "$module") || puppet module install "$module"
done

