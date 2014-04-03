class php::sqlite {
  package {"php5-sqlite":
    ensure => latest,
    notify => Service['apache2']
  }
}