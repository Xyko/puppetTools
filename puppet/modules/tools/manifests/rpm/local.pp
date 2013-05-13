define tools::rpm::local( $pack_name ) {


	notice ($pack_name)

	package { $pack_name:

		ensure   => installed,
		provider => rpm,
		source   => "puppet:///tools/files/rpm//${pack_name}",

	} 


}
