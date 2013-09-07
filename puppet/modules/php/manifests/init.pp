# = Class: php
#
# Simply install PHP5 and PHP5-CLI from package sources. Should work on every
# OS that has packages called 'php5' and 'php5-cli' in it's package sources.
#
# This module does not take care of installing any HTTP daemon in the system.
#
# == Parameters:
# 
# $httpd::  Specified which type of HTTP server is installed. Only supported 
#           value right now is apache, which leads to 'libapache2-mod-php5'
#           being installed. If left empty, nothing will happen. If any other
#           value is used, this will cause an error.
#
# == Requires:
# 
# Nothing.
#
# == Sample Usage:
#
#   class {'php':}
#
class php ($mysql = "false") {
  package { "php5":
    ensure  => latest,
  }

  package { "libapache2-mod-php5": ensure => latest, notify => Service["apache2"] }

  if "${mysql}" == "true" {
    class {"php::mysql":}
  }
}