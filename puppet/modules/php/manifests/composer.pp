# = Class: php-composer
#
# Install the composer dependency manager (http://getcomposer.org/) for PHP 
# globally in "/usr/local/bin". As a side-effect it also installs curl as this
# is required to fetch the composer installer. (There might be other ways, but
# this one is simple and works for now).
#
# This module requires a PHP5 Command Line interpreter to be installed, the 
# name of this package defaults to 'php5-cli' but can be changed if necessary
#
# == Parameters:
# 
# $phpcli_package:: the name of the PHP CLI package to install, defaults to 
#                   'php5-cli'.
#
# == Requires:
# 
# jhenning/php5 or anything else that declares a Package[$phpcli_package]
#
# == Sample Usage:
#
#   class {'php-composer':}
#
class php::composer ($phpcli_package = "php5-cli") {

  class { "coreutil::curl":}

  exec { "fetch composer":
    command => "curl -sS https://getcomposer.org/installer | php",
    require => [Class["coreutil::curl"], Class["php::cli"]],
    unless  => "test -f /usr/local/bin/composer",
    path    => ["/usr/bin", "/usr/sbin"]
  }

  exec { "copy composer bin": 
    command => "mv composer.phar /usr/local/bin/composer",
    require => Exec["fetch composer"],
    unless  => "test -f /usr/local/bin/composer",
    path    => ["/bin", "/usr/bin", "/usr/sbin"],
  }
}