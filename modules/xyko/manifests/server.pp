class xyko::server inherits xyko::common {


  file {
    "/home/xyko/alias":
      ensure => file,
      source => "puppet:///modules/xyko/alias";
  }

}