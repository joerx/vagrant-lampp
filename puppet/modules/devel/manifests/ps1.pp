class devel::ps1 {

  file { "git-prompt": 
    ensure  => file,
    source  => "puppet:///modules/devel/git-prompt",
    path    => "/home/vagrant/.git-prompt"
  }

  file { "ps1": 
    ensure  => file,
    source  => "puppet:///modules/devel/ps1",
    path    => "/home/vagrant/.ps1",
    require => File["git-prompt"]
  }

  file_line { "source ps1":
    ensure  => present,
    line    => "source ~/.ps1",
    require => File["ps1"],
    path    => "/home/vagrant/.bashrc"
  }
}