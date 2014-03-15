class php::phpunit {

  exec {"pear install phpunit":
    require => Class["php::pear"],
    command => "/usr/bin/pear install --alldeps pear.phpunit.de/PHPUnit",
    creates => "/usr/bin/phpunit",
    returns => [0, '']
  }

  exec {"pear install phpunit-selenium":
    require => [Exec["pear install phpunit"], Package["php5-curl"]],
    command => "/usr/bin/pear install --alldeps phpunit/PHPUnit_Selenium",
    creates => "/usr/share/php/PHPUnit/Extensions/Selenium2TestCase/",
    returns => [0, '']
  }

  exec {"pear install phpunit-dbunit":
    require => Exec["pear install phpunit"],
    command => "/usr/bin/pear install --alldeps phpunit/DbUnit",
    creates => "/usr/share/php/PHPUnit/Extensions/Database/",
    returns => [0, '']
  }

  exec {"pear install phpunit-story":
    require => Exec["pear install phpunit"],
    command => "/usr/bin/pear install --alldeps phpunit/PHPUnit_Story",
    creates => "/usr/share/php/PHPUnit/Extensions/Story/",
    returns => [0, '']
  }
}