# 0-strace_is_your_friend.pp
# This Puppet manifest ensures that the Apache server returns a 200 OK status by fixing common issues like file permissions and ensuring necessary directories exist.

# Ensure the Apache service is running
service { 'apache2':
  ensure => running,
  enable => true,
}

# Fix file permissions for the web directory
file { '/var/www/html':
  ensure  => directory,
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0755',
  recurse => true,
}

# Ensure index.php exists with correct permissions
file { '/var/www/html/index.php':
  ensure  => file,
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
  content => "<?php echo 'Hello, World!'; ?>",
  require => File['/var/www/html'],
}

# Ensure the Apache service is restarted if the configuration changes
exec { 'restart_apache':
  command     => '/etc/init.d/apache2 restart',
  refreshonly => true,
  subscribe   => File['/var/www/html/index.php'],
}

