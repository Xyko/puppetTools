define tools::rpm::local( $package ) {
    package { $package:
    source => "puppet:///tools/rpm/solr_generic_globo-4.2.1-2.el5.noarch.rpm"
   } 
}
