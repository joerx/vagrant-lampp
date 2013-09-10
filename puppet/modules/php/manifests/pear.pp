class php::pear {
	package {"php-pear":
		ensure => latest,
		notify => [Exec["pear upgrade"], Exec["pear update-channels"]]
	}

	exec {"pear upgrade":
		command => "/usr/bin/pear upgrade",
		require => Package["php-pear"],
		returns => ['0', ' ', ''],
		refreshonly => true
	}

	exec {"pear autodiscover":
		command => "/usr/bin/pear config-set auto_discover 1",
		require => Package["php-pear"],
	}

	exec {"pear update-channels":
		command => "/usr/bin/pear update-channels",
		require => Package["php-pear"],
		refreshonly => true
	}
}