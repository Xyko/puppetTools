class xyko::server inherits xyko::common {

	file {
	"/etc/${projeto}.txt":
		ensure => file,
		source => "puppet:///modules/xyko/teste.txt";
	}

}