define tools::rpm::local( $pack_name ) {


	notice (puppet:///tools/rpm//${pack_name})

	package { $pack_name:

		ensure   => installed,
		provider => rpm,
		source   => "puppet:///tools/rpm//${pack_name}",

	} 


}
