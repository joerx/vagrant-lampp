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

  file { "enable_mod_rewrite":
    path => "/etc/apache2/mods-enabled/rewrite.load",
    ensure => "link",
    target => "/etc/apache2/mods-available/rewrite.load",
    require => Package["apache2"],
    notify => Service["apache2"]
  }
}