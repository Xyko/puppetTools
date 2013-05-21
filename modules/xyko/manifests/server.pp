class xyko::server inherits xyko::common {

    include xyko::users

    notice is_ip_address('190.10.3.3')
    debug_msg("alert", "Send as a debug message")

    # xyko::extract {"nginx-1.4.0":
    #     ensure      => present,
    #     target      => "/opt/",
    #     extension   => 'tar.gz',
    #     execute     => "bash -c 'cd /opt/nginx-1.4.0 && ./configure --prefix=/opt/${projeto}/nginx && make && make install'",
    # }

    # # Initscripts
    # file { "/opt/${projeto}/nginx/conf/nginx.conf":
    #     ensure  => present,
    #     owner   => "root",
    #     group   => "root",
    #     mode    => "755",
    #     content => template("xyko/nginx.conf.erb"),
    # }

    tools::rvm { "gemset create":  ruby => "ruby-2.0.0-p195", gemset => "xyko" }
    tools::rvm { "gem install":  ruby => "ruby-2.0.0-p195", gemset => "xyko", gem => "rails" }
    tools::rvm { "gem install":  ruby => "ruby-2.0.0-p195", gemset => "xyko", gem => "mechanize" }
    tools::rvm { "gem install":  ruby => "ruby-2.0.0-p195", gemset => "xyko", gem => "unicorn" }
    tools::rvm { "gem install":  ruby => "ruby-2.0.0-p195", gemset => "xyko", gem => "nokogiri" }
    tools::rvm { "gem install":  ruby => "ruby-2.0.0-p195", gemset => "xyko", gem => "highline" }
    tools::rvm { "gem install":  ruby => "ruby-2.0.0-p195", gemset => "xyko", gem => "devise" }
    tools::rvm { "gem install":  ruby => "ruby-2.0.0-p195", gemset => "xyko", gem => "hpricot" }
    tools::rvm { "gem install":  ruby => "ruby-2.0.0-p195", gemset => "xyko", gem => "mysql2" }
    tools::rvm { "gem install":  ruby => "ruby-2.0.0-p195", gemset => "xyko" ,gem => "rufus-scheduler" }

}