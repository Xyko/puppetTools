class xyko::server inherits xyko::common {

    $user = "xyko"

    group { "group_${user}":
        ensure  => present,
        gid     => "10000",
    }

    user  { "${user}":
        ensure      => present,
        uid         => "10000",
        gid         => "10000",
        password    => "fc4vbRND",
        home        => "/home/${user}",
        managehome  => true,
        shell       => "/bin/bash",
        groups      => $user,
        require     => Group[$user],
    }



}