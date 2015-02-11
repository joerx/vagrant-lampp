class php::xdebug {
  package { "php5-xdebug": 
    ensure => latest,
    require => Package["php5"]
  }

  file { "xdebug.ini":
    source => "puppet:///modules/php/xdebug.ini",
    path => "/etc/php5/mods-available/xdebug.ini",
    require => Package["php5-xdebug"],
    ensure => present,
    owner => root,
    group => root,
  }

  file { "enable_xdebug":
    path => "/etc/php5/apache2/conf.d/20-xdebug.ini",
    ensure => link,
    target => "../../mods-available/xdebug.ini",
    require => File["xdebug.ini"],
    notify => Service["apache2"]
  }
}