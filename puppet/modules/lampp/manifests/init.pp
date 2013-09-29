class lampp {
  class {"httpd":}
  class {"mysql::server": config_hash => { "root_password" => "root", "bind_address" => "0.0.0.0" }}
  class {"php": mysql => "true"} 
}