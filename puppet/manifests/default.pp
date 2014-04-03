# Either provided by facter (see Vagrantfile) or use defaults
# if size("${apt_mirror}") == 0 { $apt_mirror = "archive.ubuntu.com" }
if size("${site_name}") == 0 { $site_name = "my_site" }

# Set up package repos in init stage
# stage { "init": before  => Stage["main"] }
# class { "apt-mirror": 
#   stage => init, 
#   apt_mirror => $apt_mirror 
# }

# LAMPP Stack - Apache2, PHP, Skip MySQL (faster)
class { "lampp": 
  mysql => false,
  ppa => true
}

class { "sqlite": }

# Development tools - Vim, Git, Bash prompt, ...
class { "devel": }

# Composer
class { "php::composer": }

# Site config - Apache vhost, MySQL database
class { "site": 
  site_name => $site_name,
  docroot => "/var/www/${site_name}/app"
}
