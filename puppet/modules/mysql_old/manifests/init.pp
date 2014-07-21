# vagrant/puppet/modules/mysql/manifests/init.pp
class mysql {
  # Install mysql
  package { ['mysql-server', 'mysql-client']:
    ensure => present,
    require => Exec['apt-get update'],
  }
  # Run mysql
  service { 'mysql':
    ensure  => running,
    require => Package['mysql-server'],
  }
  # Use a custom mysql configuration file
  file { '/etc/mysql/my.cnf':
    source  => 'puppet:///modules/mysql/my.cnf',
    require => Package['mysql-server'],
    notify  => Service['mysql'],
  }
  # We set the root password here
  exec { 'set-mysql-password':
    unless  => 'mysqladmin -uroot status',
    command => "mysqladmin -uroot password ''",
    path    => ['/bin', '/usr/bin'],
    require => Service['mysql'],
  }
}