class xyko::server inherits xyko::common {

	# file {
	# "/etc/${projeto}.txt":
	# 	ensure => file,
	# 	source => "puppet:///modules/xyko/teste.txt";
	# }

	tools::users::create { teste:
        usuario     => "flipper2",
        grupo       => "flipper2",
        uid         => "13101",
        gid         => "13101",
        password    => "flipper2",
        home_dir	=> "/home/flipper2"
	}


	# # Initscripts
 #    file { "/etc/init.d/teste":
 #        ensure  => present,
 #        owner   => "root",
 #        group   => "root",
 #        mode    => "755",
 #        content => template("xyko/teste.erb"),
 #    }

 #    tools::rpm_release { ant: version => 'latest' }

 #    rpm_release { teste: version => 'latest'}

 #    package { "teste2":
 #    source => "puppet:///tools/files/solr_generic_globo-4.2.1-2.el5.noarch.rpm"
 #   } 


}