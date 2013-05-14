define tools::rpm::local( $pack_name ) {

	notice ($pack_name)
	notice ($uptime)

	file {
	"/tmp/${pack_name}":
		ensure => file,
		source => "puppet:///modules/tools/rpm/${pack_name}",
	}

	package { $pack_name:
		ensure   => present,
		provider => rpm,
		source	 => "puppet://modules/tools/rpm/${pack_name}",
		#source   => "/tmp/${pack_name}",
		#require => File["/tmp/${pack_name}"],
	} 

}
