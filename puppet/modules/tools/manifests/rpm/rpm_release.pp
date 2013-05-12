#
# Sugestão de uso:
#
# class rpm::solr_generic_globo-3.3.0-1 {
#     rpm_release { solr_generic_globo: version => "3.3.0-1" }
# }
#

define tools::rpm::rpm_release( $package=false, $version ) {
    $pkg = $package ? {
        false   => $name,
        default => $package,
    }
    # Usando variaveis do facter
    if ( $operatingsystemrelease >= 4 ) and ( $operatingsystemrelease < 5 ) {
        $release = "el4" 
    } 
    else { 
        if ( $operatingsystemrelease >= 5 ) and ( $operatingsystemrelease < 6 ) {
            $release = "el5"
        } 
        else {
          if ( $operatingsystemrelease >= 6 ) and ( $operatingsystemrelease < 7 ) {
              $release = "el6"
          } else {
            # Poderiamos ter o el7, mas ainda não...
            fail( "Sistema operacional não suportado" )
          }
        } 
    } 

    if($version=="latest"){
        ## Qdo eh latest nao precisa colocar a release
        $ensure = "$version"
    }else{
        $ensure = "$version.$release"
    }

    package { $pkg: ensure => "$ensure" }
}

# EOF
