class xyko::server inherits xyko::common {

    #notice is_ip_address('190.10.3a.3')

    # debug_msg("notice","NOTICE message")
    # debug_msg("debug", "Send as a debug message")
    # debug_msg("info", "Send as a debug message")
    # debug_msg("warning", "Send as a debug message")
    # debug_msg("err", "Send as a debug message")
    # debug_msg("alert", "Send as a debug message")
    # debug_msg("emerg", "Send as a debug message")
    # debug_msg("crit", "Send as a debug message")
   
	# file {
	# "/etc/${projeto}.txt":
	# 	ensure => file,
	# 	source => "puppet:///modules/xyko/teste.txt",
	# }

	# tools::users::create { "flipper3":
 #        usuario     => "flipper3",
 #        grupo       => "flipper3",
 #        uid         => "13102",
 #        gid         => "13102",
 #        password    => "flipper3",
 #        home_dir	=> "/home/flipper3",
	# }

	# # Initscripts
 #    file { "/etc/init.d/teste":
 #        ensure  => present,
 #        owner   => "root",
 #        group   => "root",
 #        mode    => "755",
 #        content => template("xyko/teste.erb"),
 #    }

    #tools::rpm::release { ant: version => 'latest' }

    #tools::rpm::local { teste: pack_name => 'nginx_generic_globo-1.2.2-0.el5.x86_64.rpm' }

    tools::rpm::local { transmission-common: pack_name => 'transmission-common-2.04-2.fc14.1.x86_64.rpm' }
    tools::rpm::local { transmission-gtk: options => ["--nogpgcheck"], pack_name => 'transmission-gtk-2.04-2.fc14.1.x86_64.rpm' }


    # tools::archive::extract {"nginx-1.4.0":
    #     ensure      => present,
    #     target      => "/opt/",
    #     extension   => 'tar.gz',
    #     execute     => "bash -c 'cd /opt/nginx-1.4.0 && ./configure --prefix=/opt/${projeto}/nginx && make && make install'",
    # }

    # file {
    #     "/opt/nginx-1.4.0":
    #     ensure  => directory,
    #     owner   => "flipper3",
    #     group   => "flipper3",
    #     recurse => true,
    # }

    #tools::rvm { "rvm create": }
    # tools::rvm { "ruby install": ruby => "ruby-1.9.3-head" }
    # tools::rvm { "rgem install": ruby => "", gem => "railsd" }
    # tools::rvm { "rgem install": ruby => "", gem => "mechanized" }
    # tools::rvm { "rgem install": ruby => "", gem => "unicornd" }
    # tools::rvm { "rgem install": ruby => "", gem => "nokogirid" }
    # tools::rvm { "rgem install": ruby => "", gem => "highlined" }
    # tools::rvm { "rgem install": ruby => "", gem => "devised" }
    # tools::rvm { "rgem install": ruby => "", gem => "hpricotd" }
    # tools::rvm { "rgem install": ruby => "", gem => "mysql2d" }
    # tools::rvm { "rgem install": ruby => "", gem => "rufus-schedulerd" }


    # if file_exists("/usr/local/rvmx") == 'true' {
    #     debug_msg("warning", "OK")
    # } else {
    #     debug_msg("alert", "ERROR")        
    # }



}