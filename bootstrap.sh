#!/bin/bash
#install puppet modules in case necessary
[ -d /etc/puppet/modules ] || mkdir -p /etc/puppet/modules
for module in "" ; do
  (puppet module list | grep "$module") || puppet module install "$module"
done

