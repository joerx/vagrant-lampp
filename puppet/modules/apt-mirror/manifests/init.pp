# = Class: apt-mirror
#
# This allows to globally change Ubuntu package sources to another mirror. It's 
# handy to customize the pre-packaged sources.list file of a base box to some-
# thing closer to your actual location.
# 
# At the moment it's using a quite violent approach by simple replacing the 
# existing /etc/apt/sources.list with one generated from a template included 
# with this module. Hence, the applicability of this module is rather limited,
# it's just configured for use with Ubuntu Precise (12.04).
#
# I may change this to something in the ways of grep/sed/awk in the future so 
# can modify an existing sources list instead of replacing it.
#
# WARNING: do not use this with anything else than Ubuntu Precise (12.04), as 
# it will most likely shred your box to pieces in any other case!
#
# As a side effect, it also updates the package sources every time the class is
# used. This is what I mostly want for my development boxes, so it's fine for
# now.
#
# It's advised to use this in a separate stage run before the main stage, as 
# most other customizations are likely depending on the package sources set up
# here.
#
# == Parameters: 
# 
# $apt_mirror:: Base url of the mirror to use, default is "archive.ubuntu.com"
#
# == Requires:
#
# Nothing.
#
# == Sample Usage:
# 
#   stage { "init": before  => Stage["main"] }
#
#   class {"apt-mirror": 
#     stage => init, 
#     apt_mirror => "us.archive.ubuntu.com" 
#   }
#
class apt-mirror ($apt_mirror = "archive.ubuntu.com") {
  file { "sources.list":
    path    => "/etc/apt/sources.list",
    ensure  => "present",
    content => template("apt-mirror/sources.list.erb"),
    notify  => Exec["apt-update"],
    owner   => "root",
    group   => "root"
  }

  exec { "apt-update":
    command => "/usr/bin/apt-get update",
    returns => [0, 100],
    refreshonly => true
  }
}