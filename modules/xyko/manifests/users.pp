class xyko::users inherits xyko::common {

    $user = "xyko"

    group { $user:
        ensure  => present,
        gid     => "10000",
    }

    user  { $user:
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