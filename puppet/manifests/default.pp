# Either provided by facter (see Vagrantfile) or use defaults
if size("${apt_mirror}") == 0 { $apt_mirror = "archive.ubuntu.com" }
if size("${site_name}") == 0 { $site_name = "my_site" }

# Set up package repos in init stage
stage { "init": before  => Stage["main"] }
class {"apt-mirror": 
  stage => init, 
  apt_mirror => $apt_mirror 
}

# LAMPP Stack - Apache2, MySQL, PHP
class {"lampp":}

# Development tools - Vim, Git, Bash prompt and PHP Development tools (Composer, CLI)
class {"devel":}
class {"devel::php":}

# Site config - Apache vhost, MySQL database
class {"site": 
  site_name => $site_name
}
