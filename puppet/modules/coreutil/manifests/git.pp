class coreutil::git {
  package { "git-core":
    ensure => latest
  }
}