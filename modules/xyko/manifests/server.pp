class xyko::server inherits xyko::common {

	import "tools/defines/*"

	file {
	"/etc/${projeto}.txt":
		ensure => file,
		source => "puppet:///modules/xyko/teste.txt";
	}

	create_user { teste:
        usuario     => "flipper",
        grupo       => "flipper",
        uid         => "13100",
        gid         => "13100",
        password    => "flipper",
        home_dir	=> "/home/flipper"
	}


	# Initscripts
    file { "/etc/init.d/teste":
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => "755",
        content => template("/xyko/teste.erb"),
    }

 	rpm_release { gcc: version => 'latest' }


}