class xyko::server inherits xyko::common {

    notice is_ip_address('190.10.3a.3')

	file {
	"/etc/${projeto}.txt":
		ensure => file,
		source => "puppet:///modules/xyko/teste.txt",
	}

	tools::users::create { "flipper3":
        usuario     => "flipper3",
        grupo       => "flipper3",
        uid         => "13102",
        gid         => "13102",
        password    => "flipper3",
        home_dir	=> "/home/flipper3",
	}

	# Initscripts
    file { "/etc/init.d/teste":
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => "755",
        content => template("xyko/teste.erb"),
    }

    #tools::rpm::release { ant: version => 'latest' }

    #tools::rpm::local { teste: pack_name => 'nginx_generic_globo-1.2.2-0.el5.x86_64.rpm' }

    tools::archive::extract {"nginx-1.4.0":
        ensure      => present,
        target      => "/opt/",
        extension   => 'tar.gz',
        execute     => "bash -c 'cd /opt/nginx-1.4.0 && ./configure --prefix=/opt/${projeto}/nginx && make && make install'",
    }

    # file {
    #     "/opt/nginx-1.4.0":
    #     ensure  => directory,
    #     owner   => "flipper3",
    #     group   => "flipper3",
    #     recurse => true,
    # }

    tools::rvm::create { "rvm create":
        owner => "flipper3",

    }



}