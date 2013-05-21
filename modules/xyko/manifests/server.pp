class xyko::server inherits xyko::common {

    include xyko::users

    xyko::extract {"nginx-1.4.0":
        ensure      => present,
        target      => "/opt/",
        extension   => 'tar.gz',
        execute     => "bash -c 'cd /opt/nginx-1.4.0 && ./configure --prefix=/opt/${projeto}/nginx && make && make install'",
    }

}