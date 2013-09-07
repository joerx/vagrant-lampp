class php::mysql {
  package {"php5-mysql":
    ensure => latest,
    notify => Service['apache2']
  }
}