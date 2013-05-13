define tools::rpm::local( $pack_name ) {

	notice ($pack_name)
	notice ($uptime)


	file {
	"/home/xyko/${pack_name}.txt":
		ensure => file,
		source => "puppet:///modules/tools/rpm/${pack_name}";
	}


	# package { $pack_name:

	# 	ensure   => installed,
	# 	provider => rpm,
	# 	#source   => "/home/xyko/puppetTools/puppet/modules/tools/files/rpm/${pack_name}",
	# 	source   => "puppet:///tools/rpm//${pack_name}",

	# } 

}
