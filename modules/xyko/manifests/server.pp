class xyko::server inherits xyko::common {


    tools::rpm::yum {yum1: packlist => ["git","gcc-c++","patch","readline","ImageMagick"]}
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



}