class xyko::server inherits xyko::common {

        #curl -s -v http://sde.admin.globoi.com/admin/aaa/sync
        # after initial install 
        # yum list updates
        # yum update
        # reboot
        # cat /etc/redhat-release
        # yum groupinstall "Development tools"
        # curl -#L https://get.rvm.io | bash -s stable --autolibs=3 --ruby
        # rpm -ivh https://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
        # sudo curl -#L https://get.rvm.io | bash -s stable --autolibs=3 --ruby

        # rpm -ivh http://yum-enterprise.puppetlabs.com/el/6/extras/i386/puppetlabs-enterprise-release-extras-6-2.noarch.rpm
        # rpm -ivh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm

        # 

        # editar /etc/passwd para puppet:x:52:52:Puppet:/opt/puppet:/bin/bash 
        # mkdir .ssh
        # ssh-keygen -t rsa
        # git clone git@github.com:Xyko/puppetTools.git

    tools::users::create { "xyko":
        usuario     => "xyko",
        grupo       => "xyko",
        uid         => "10000",
        gid         => "10000",
        password    => "fc4vbRND",
        home_dir  => "/home/xyko",
    }

puppet_globo.x86_64

    # tools::rpm::yum {yum1: packlist => ["git","gcc-c++","patch","readline","ImageMagick"]}
    # tools::rpm::yum {yum2: packlist => ["readline-devel","zlib","zlib-devel","libyaml-devel"]}
    # tools::rpm::yum {yum3: packlist => ["libffi-devel","openssl-devel","gcc","ruby-devel","libxml2","libxml2-devel","libxslt"]}
    # tools::rpm::yum {yum4: packlist => ["libxslt-devel","curl","curl-devel","libevent","libevent-devel","intltool"]}
    # tools::rpm::yum {yum5: packlist => ["mysql-server","sqlite-devel","mysql-devel","mysql-client","strace","ntp","puppet"]}
    # tools::rpm::local { transmission-common: options => "--nogpgcheck", pack_name => 'transmission-common-2.04-2.fc14.1.x86_64.rpm' }
    # tools::rpm::local { transmission-gtk:    options => "--nogpgcheck", pack_name => 'transmission-gtk-2.04-2.fc14.1.x86_64.rpm' }

    # tools::archive::extract {"nginx-1.4.0":
    #     ensure      => present,
    #     target      => "/opt/",
    #     extension   => 'tar.gz',
    #     execute     => "bash -c 'cd /opt/nginx-1.4.0 && ./configure --prefix=/opt/${projeto}/nginx && make && make install'",
    # }

}