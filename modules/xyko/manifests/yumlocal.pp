define xyko::yumlocal( $pack_name, $options='') {

	file {
	"/tmp/${pack_name}":
		ensure => file,
		source => "puppet:///modules/xyko/rpm/${pack_name}",
	}

	package { $pack_name:
		ensure   => installed,
		provider => rpm,
		source   => "/tmp/${pack_name}",
		require => File["/tmp/${pack_name}"],
		install_options => ["${options}"],
	} 

}
