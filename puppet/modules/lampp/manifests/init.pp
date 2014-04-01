class lampp ($mysql = "true") {

  if "${mysql}" == "true" {
    class {"mysql::server": 
      root_password    => "root", 
      override_options => { "mysqld" => { "bind_address" => "0.0.0.0", "key_buffer_size" => "16M" }}
    }
  }
  
  class {"httpd":}
  class {"php":} 
}