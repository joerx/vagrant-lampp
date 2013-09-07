# = Class: httpd
#
# Simplest possible approach to install and run Apache2 httpd on Debian/Ubuntu.
# Just ensures package 'apache2' is the latest available version and the that 
# the service is running. Does not update package sources by itself, so if 
# 'latest' means the latest version in the current local package index.
#
# == Parameters:
# 
# Nothing.
#
# == Requires:
# 
# Nothing.
#
# == Sample Usage:
#
#   class {'httpd':}
#
class httpd {
  package { "apache2":
    ensure  => latest,
  }

  service { "apache2":
    ensure  => running,
    require => Package["apache2"]
  }

  # We need to explicitly add www-user to vagrant to allow write access to application
  user { "www-data":
    ensure => present,
    groups => vagrant,
    require => Package["apache2"]
  }
}