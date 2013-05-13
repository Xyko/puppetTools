define tools::rpm::local( $pack_name ) {


	notice ($pack_name)

    package { $package:
    source => "puppet:///tools/rpm/${pack_name}",
    ensure => present,
   } 

}
