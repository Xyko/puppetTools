class xyko::server inherits xyko::common {

	import "tools/defines/*"

	file {
	"/etc/${projeto}.txt":
		ensure => file,
		source => "puppet:///modules/xyko/teste.txt";
	}

	create_user { teste:
		usuario  => "$usuario_projeto",
		password => "$usuario_senha_projeto",
	}


}