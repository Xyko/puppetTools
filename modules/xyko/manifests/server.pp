class xyko::server inherits xyko::common {

	include tools::user

	file {
	"/etc/${projeto}.txt":
		ensure => file,
		source => "puppet:///modules/xyko/teste.txt";
	}



}