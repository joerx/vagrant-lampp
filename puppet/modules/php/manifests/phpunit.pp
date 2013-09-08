class php::phpunit {

  exec {"pear install phpunit":
    require => Class["php::pear"],
    command => "/usr/bin/pear install --alldeps pear.phpunit.de/PHPUnit",
    creates => "/usr/bin/phpunit",
  }

  exec {"pear install phpunit-selenium":
    require => [Class["php::pear"], Package["php5-curl"]],
    command => "/usr/bin/pear install --alldeps phpunit/PHPUnit_Selenium",
    creates => "/usr/share/php/PHPUnit/Extensions/Selenium2TestCase/",
  }

  exec {"pear install phpunit-dbunit":
    require => Class["php::pear"],
    command => "/usr/bin/pear install --alldeps phpunit/DbUnit",
    creates => "/usr/share/php/PHPUnit/Extensions/Database/",
  }

  exec {"pear install phpunit-story":
    require => Class["php::pear"],
    command => "/usr/bin/pear install --alldeps phpunit/PHPUnit_Story",
    creates => "/usr/share/php/PHPUnit/Extensions/Story/"
  }
}