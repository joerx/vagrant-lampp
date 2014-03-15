class php::phing {

	exec {"pear discover phing":
		require => Class["php::pear"],
		command => "/usr/bin/pear channel-discover pear.phing.info",
		returns => [0, ''],
		unless => "/usr/bin/pear list-channels | /bin/grep pear.phing.info",
	}

	exec {"pear install phing":
		require => Exec["pear discover phing"],
		command => "/usr/bin/pear install --alldeps phing/phing",
		creates => "/usr/bin/phing",
		returns => [0, '']
	}
}