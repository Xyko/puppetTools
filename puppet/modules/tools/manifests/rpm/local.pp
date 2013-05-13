define tools::rpm::local( $pack_name ) {


	notice ($pack_name)

	package { $pack_name:
	source => "puppet:///tools/rpm/${pack_name}",
	ensure => present,
	} 

}
