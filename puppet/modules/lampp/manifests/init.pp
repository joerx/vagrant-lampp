class lampp {
  class {"httpd":}
  class {"mysql::server": 
  	root_password    => 'root', 
  	override_options => { "mysqld" => { "bind_address" => "0.0.0.0", "key_buffer_size" => "16M" }}
  }
  class {"php": mysql => "true"} 
}