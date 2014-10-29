exec { 'set_document_root':
  command => 'ln -fs /vagrant/web-root/* /var/www',
  onlyif => '[ ! -h /var/www ]',
  path => '/usr/bin:/bin',
}

file { '/var/www/':
  ensure => 'directory',
}

exec { 'apt-get update':
  path => '/usr/bin'
}

#package { ['python-software-properties', 'vim', 'git']:
#  ensure => present,
#  require => Exec['apt-get update'],
#}

include nginx