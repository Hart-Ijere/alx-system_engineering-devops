# This Puppet manifest installs Flask version 2.1.0 using pip3.

# Ensure the python3 package is installed
package { 'python3':
  ensure => installed,
}

# Ensure pip3 is installed
package { 'python3-pip':
  ensure => installed,
  require => Package['python3'],
}

# Install Flask version 2.1.0 using pip3
exec { 'install_flask':
  command => '/usr/bin/pip3 install flask==2.1.0',
  unless  => '/usr/bin/pip3 show flask | grep -q "^Version: 2.1.0$"',
  require => Package['python3-pip'],
}


