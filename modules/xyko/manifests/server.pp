class xyko::server inherits xyko::common {

  file {
    "/etc/teste.txt":
      ensure => file,
      source => "puppet:///modules/xyko/teste.txt";
  }

}