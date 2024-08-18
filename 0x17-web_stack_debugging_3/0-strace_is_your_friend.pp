# 0-strace_is_your_friend.pp
# This Puppet manifest fixes the issue causing Apache to return a 500 error by ensuring the correct file permissions are set.

exec { 'fix-apache-permissions':
  command => 'chmod 755 /var/www/html',
  path    => ['/bin', '/usr/bin'],
  onlyif  => 'test $(stat -c "%a" /var/www/html) -ne 755',
}

file { '/var/www/html/index.php':
  ensure => file,
  mode   => '0644',
  owner  => 'www-data',
  group  => 'www-data',
  source => 'puppet:///modules/your_module/index.php',
}

service { 'apache2':
  ensure    => running,
  enable    => true,
  subscribe => Exec['fix-apache-permissions'],
}


