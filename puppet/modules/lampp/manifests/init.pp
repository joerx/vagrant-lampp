class lampp ($mysql = "true", $ppa = "false") {

  # This will load the PPA if $ppa is true, otherwise we use default repos
  class {"lampp::ppa":
    ppa => "$ppa"
  }

  # Only install MySQL if required
  if "${mysql}" == "true" {
    class {"mysql::server": 
      root_password    => "root", 
      override_options => { "mysqld" => { "bind_address" => "0.0.0.0", "key_buffer_size" => "16M" }}
    }
  }
  
  class {"apache2":
    require => Class["lampp::ppa"]
  }
  
  class {"php":
    require => Class["lampp::ppa"]
  } 
}