# = Class: site
#
# Configures a default web site configuration for Apache2 on Debian/Ubuntu,
# replacing the default configuration that comes preconfigured with the Apache
# package in Debian-like OSes. 
#
# It follows the standard way of doing things on Debian, using the 
# 'sites-available' and 'sites-enabled' folders and the 'a2ensite/a2dissite' 
# tools to link/unlink the site configs correctly. 
#
# The module depends heavily on Apache2 being declared as a package and a 
# service in the way jhenning/httpd is doing it.
#
# == Parameters:
#
# $site_name:: name for the site base dir under /var/www and the configuration
#              file name. Defaults to 'my_site'.
# $docroot::   document root for the site, if empty the same value as for 
#              $site_name will be used. Default is empty.
#
# == Requires: 
# 
# jhenning/httpd or anything else declaring Package['apache2'] and 
# Service['apache2']
#
# == Sample Usage:
#
#   class {"site": 
#     site_name => $site_name
#   }
# 
class site ($site_name = "my_site", $docroot = "") {

  if size("${docroot}") == 0 { 
    $document_root = "/var/www/${site_name}" 
  } else {
    $document_root = "${docroot}"
  }

  file { "site-conf":
    require => Package["apache2"],
    path    => "/etc/apache2/sites-available/${site_name}",
    content => template("site/site.conf.erb"),
    ensure  => file,
    owner   => "root",
    group   => "root"
  }

  file { "site-root":
    path    => "/var/www/${site_name}",
    ensure  => directory
  }

  exec { "enable-site":
    command => "a2dissite default && a2ensite ${site_name}",
    require => [File["site-root"], File["site-conf"]],
    path    => ["/usr/bin", "/usr/sbin"],
    notify  => Service["apache2"],
    unless  => "test -h /etc/apache2/sites-enabled/${site_name}"
  }

  mysql::db { $site_name: 
    user     => $site_name,
    password => $site_name,
    host     => "localhost",
    grant    => ["all"]
  }
}