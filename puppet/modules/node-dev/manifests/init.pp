class node-dev {

  if !defined(Class['apt']) {
    class {'apt':}
  }

  apt::ppa {'ppa:chris-lea/node.js':}

  package {'nodejs':
    ensure => 'latest',
    require => Apt::Ppa['ppa:chris-lea/node.js']
  }

  package {['nodemon']:
    provider => 'npm',
    require => Package['nodejs']
  }

}