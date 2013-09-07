class php::phpunit {

  exec {"fetch phpunit":
    command => "wget http://pear.phpunit.de/get/phpunit.phar",
    cwd     => "/tmp",
    path    => ["/usr/bin", "/usr/sbin"],
    unless  => "test -f /usr/local/bin/phpunit"
  }

  file {"install global":
    ensure  => "file",
    path    => "/usr/local/bin/phpunit",
    source  => "/tmp/phpunit.phar",
    mode    => 0755,
    owner   => "root",
    group   => "root",
    require => Exec["fetch phpunit"]
  }
}