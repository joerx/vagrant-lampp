class lampp {
  class {"httpd":}
  class {"mysql::server": config_hash => { "root_password" => "root" }}
  class {"php": mysql => "true"} 
}