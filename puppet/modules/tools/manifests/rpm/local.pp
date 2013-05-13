define tools::rpm::local( $pack_name ) {


	notice ($pack_name)

	package { $pack_name:

		ensure   => installed,
		provider => rpm,
		source   => "/home/xyko/puppetTools/puppet/modules/tools/files/rpm//${pack_name}",

	} 


}
