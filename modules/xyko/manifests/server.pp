class xyko::server inherits xyko::common {

    include xyko::users

    # xyko::extract {"nginx-1.4.0":
    #     ensure      => present,
    #     target      => "/opt/",
    #     extension   => 'tar.gz',
    #     execute     => "bash -c 'cd /opt/nginx-1.4.0 && ./configure --prefix=/opt/${projeto}/nginx && make && make install'",
    # }

    xyko::yumlocal { transmission-common:  options => "--nogpgcheck", pack_name => 'transmission-common-2.04-2.fc14.1.x86_64.rpm' }
    xyko::yumlocal { transmission-gtk: options => "--nogpgcheck", pack_name => 'transmission-gtk-2.04-2.fc14.1.x86_64.rpm' }

    notice is_ip_address('190.10.3.3')

}