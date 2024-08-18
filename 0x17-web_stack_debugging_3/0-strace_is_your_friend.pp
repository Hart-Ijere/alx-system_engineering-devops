# 0-strace_is_your_friend.pp
# This Puppet manifest fixes the Apache web server by ensuring the proper configuration, permissions, and file setup so that Apache returns a 200 OK status and serves the correct page.

# Ensure Apache is installed and running
package { 'apache2':
  ensure => installed,
}

service { 'apache2':
  ensure     => running,
  enable     => true,
  subscribe  => File['/var/www/html/index.html'],
}

# Ensure the document root directory exists with the correct permissions
file { '/var/www/html':
  ensure  => directory,
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0755',
}

# Ensure the index.html file exists with the correct content and permissions
file { '/var/www/html/index.html':
  ensure  => file,
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
  content => "<html>\n<head>\n<title>Holberton School</title>\n</head>\n<body>\n<h1>Hello Holberton</h1>\n<p>Welcome to your web server!</p>\n</body>\n</html>\n",
}

# Ensure Apache's default configuration is enabled
exec { 'enable_apache_default_site':
  command => '/usr/sbin/a2ensite 000-default',
  unless  => '/bin/ls /etc/apache2/sites-enabled/000-default.conf',
  notify  => Service['apache2'],
}

# Restart Apache to apply changes if necessary
exec { 'restart_apache':
  command     => '/usr/sbin/service apache2 restart',
  refreshonly => true,
  subscribe   => File['/var/www/html/index.html'],
}

