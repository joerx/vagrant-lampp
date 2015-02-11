# Either provided by facter (see Vagrantfile) or use defaults
# if size("${apt_mirror}") == 0 { $apt_mirror = "archive.ubuntu.com" }
if size("${site_name}") == 0 { $site_name = "my_site" }

# FIXME: put this somewhere else (we already have a similar task in apt-mirror
# but it's refreshonly and won't work when called directly)
class apt_update {
  exec { "do_apt_update":
    command     => "/usr/bin/apt-get update",
    timeout     => 300,
  }
}

# Set up package repos in init stage
stage { "init": before  => Stage["main"] }
class { "apt_update": 
  stage => init
}

# LAMPP Stack - Apache2, PHP, Skip MySQL (faster)
class { "lampp": 
  mysql => true,
  ppa => true
}

class { "sqlite": }

# Development tools - Vim, Git, Bash prompt, ...
class { "devel": }

# NodeJS and some useful packages
class { "node-dev": }

# Composer
class { "php::composer": }

# Site config - Apache vhost, MySQL database
class { "site": 
  site_name => $site_name,
  docroot => "/var/www/${site_name}/public"
}
