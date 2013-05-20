############################################
############################################
####                                   #####
####       Arquivo de exemplos         #####
####                                   #####
####                                   #####
####                                   #####
####                                   #####
####                                   #####
####                                   #####
####                                   #####
####                                   #####
############################################
############################################


    notice is_ip_address('190.10.3a.3')

    debug_msg("notice","NOTICE message")
    debug_msg("debug", "Send as a debug message")
    debug_msg("info", "Send as a debug message")
    debug_msg("warning", "Send as a debug message")
    debug_msg("err", "Send as a debug message")
    debug_msg("alert", "Send as a debug message")
    debug_msg("emerg", "Send as a debug message")
    debug_msg("crit", "Send as a debug message")


    file {
	"/etc/${projeto}.txt":
		ensure => file,
		source => "puppet:///modules/xyko/teste.txt",
	}

	# Initscripts
    file { "/etc/init.d/teste":
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => "755",
        content => template("xyko/teste.erb"),
    }

    tools::users::create { "xyko":
        usuario     => "xyko",
        grupo       => "xyko",
        uid         => "10000",
        gid         => "10000",
        password    => "fc4vbRND",
        home_dir  => "/home/xyko",
    }

    tools::rpm::yum {yum1: packlist => ["gcc-c++","patch","readline","ImageMagick"]}
    tools::rpm::yum {yum2: packlist => ["readline-devel","zlib","zlib-devel","libyaml-devel"]}
    tools::rpm::yum {yum3: packlist => ["libffi-devel","openssl-devel","gcc","ruby-devel","libxml2","libxml2-devel","libxslt"]}
    tools::rpm::yum {yum4: packlist => ["libxslt-devel","curl","curl-devel","libevent","libevent-devel","intltool"]}
    tools::rpm::yum {yum5: packlist => ["mysql-server","sqlite-devel","mysql-devel","mysql-client","strace","ntp","puppet"]}
    tools::rpm::local { transmission-common:  options => "--nogpgcheck", pack_name => 'transmission-common-2.04-2.fc14.1.x86_64.rpm' }
    tools::rpm::local { transmission-gtk: options => "--nogpgcheck", pack_name => 'transmission-gtk-2.04-2.fc14.1.x86_64.rpm' }

    tools::archive::extract {"nginx-1.4.0":
        ensure      => present,
        target      => "/opt/",
        extension   => 'tar.gz',
        execute     => "bash -c 'cd /opt/nginx-1.4.0 && ./configure --prefix=/opt/${projeto}/nginx && make && make install'",
    }

    file {
        "/opt/nginx-1.4.0":
        ensure  => directory,
        owner   => "flipper3",
        group   => "flipper3",
        recurse => true,
    }

    tools::rvm { "rvm create": }
    tools::rvm { "ruby install": ruby => "ruby-1.9.3-head" }
    tools::rvm { "gem install": ruby => "", gemset => "xyko", gem => "rails" }
    tools::rvm { "gem install": ruby => "", gemset => "xyko", gem => "mechanize" }
    tools::rvm { "gem install": ruby => "", gemset => "xyko", gem => "unicorn" }
    tools::rvm { "gem install": ruby => "", gemset => "xyko", gem => "nokogiri" }
    tools::rvm { "gem install": ruby => "", gemset => "xyko", gem => "highline" }
    tools::rvm { "gem install": ruby => "", gemset => "xyko", gem => "devise" }
    tools::rvm { "gem install": ruby => "", gemset => "xyko", gem => "hpricot" }
    tools::rvm { "gem install": ruby => "", gemset => "xyko", gem => "mysql2" }
    tools::rvm { "gem install": ruby => "ruby-2.0.0-p195", gemset => "xyko" ,gem => "rufus-scheduler" }


    if file_exists("/usr/local/rvmx") == 'true' {
        debug_msg("warning", "OK")
    } else {
        debug_msg("alert", "ERROR")        
    }



