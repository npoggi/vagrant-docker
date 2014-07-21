# vagrant/puppet/modules/php/manifests/init.pp
class php {
  # Install the php5-fpm and php5-cli packages
  package { ['php5-fpm', 'php5-cli', 'php5-mysql', 'php5-xdebug']:
    ensure => present,
    require => Exec['apt-get update'],
    notify => Service['php5-fpm']
  }
  # Make sure php5-fpm is running
  service { 'php5-fpm':
    ensure => 'running',
    require => Package['php5-fpm'],
  }

  file {'/etc/php5/fpm/conf.d/90-overrides.ini':
    ensure => present,
    owner => root, group => root, mode => 444,
    notify => Service['php5-fpm'],
    content => "
zend_extension=/usr/lib/php5/20121212/xdebug.so
xdebug.default_enable = 1
xdebug.idekey = \"vagrant\"
xdebug.remote_enable = 1
xdebug.remote_autostart = 0
xdebug.remote_port = 9000
xdebug.remote_handler=dbgp
xdebug.remote_log=\"/var/log/xdebug/xdebug.log\"
xdebug.remote_host=10.0.2.2 ; IDE-Environments IP, from vagrant box.
",

  }

#
#  # Use a custom mysql configuration file
#  file { '/etc/php5/fpm/php.ini':
#    source  => 'puppet:///modules/php/php.ini',
#    require => Package['php5-fpm'],
#    notify  => Service['php5-fpm'],
#  }
#
#  # Use a custom mysql configuration file
#  file { '/etc/php5/cli/php.ini':
#    source  => 'puppet:///modules/php/php.ini',
#    require => Package['php5-cli'],
#  }

}