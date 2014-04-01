class lampp::ppa ($ppa = "false") {

  if !defined(Class["apt"]) {
    include apt
  }

  if ("${ppa}" == "true") {
    apt::ppa { "ppa:ondrej/php5": }
  }
}